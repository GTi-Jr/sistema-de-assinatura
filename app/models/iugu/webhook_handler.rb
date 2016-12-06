class Iugu::WebhookHandler
  class << self
    # Processa o evento que é passado através de requisições post pelo Iugu.
    # Seja um evento chamado 'invoices.created', este método procurará pelo método
    # :invoices_created dentro deste módulo.
    # ==== Exemplos
    #   # Dentro de seu controller:
    #
    #   webhook = Iugu::WebhookHandler.new
    #   webhook.process(params[:event], params[:data])
    def process(event, data)
      method = event.gsub('.', '_').to_sym # 'alguma.coisa' vira 'alguma_coisa'
      send(method, data)
    end

    private

    # Pega o evento de assinatura criada. A requisição de criação dela está em um
    # controller. Após ser criada no Iugu, eles mandarão uma mensagem para nosso
    # servidor e este método irá tratá-la.
    # Após criada lá, devemos criar uma assinatura referente em nossa base de dados.
    def subscription_created(data)
      iugu_subscription = Iugu::Subscription.fetch(data[:id])
      last_invoice      = iugu_subscription.recent_invoices[0]

      user = User.find_by(customer_id: iugu_subscription.customer_id)
      plan = Plan.find_by(identifier: iugu_subscription.plan_identifier)

      subscription = user.subscriptions.create do |subscription|
        subscription.plan                = plan
        subscription.iugu_id             = iugu_subscription.id
        subscription.iugu_payment_status = last_invoice ? last_invoice['status'] : 'pending'
        subscription.active              = iugu_subscription.active
        subscription.suspended_on        = Time.zone.now.to_date if iugu_subscription.suspended
      end

      subscription.build_baby(born: false).save
    end

    # Evento quando a assinatura é renovada. Devemos setar a nova data de
    # expiração.
    def subscription_renewed(data)
      subscription = ::Subscription.find_by(iugu_id: data[:id])
      subscription.set_new_expiry_date!
    end

    # Uma assinatura pode ser suspensa. Após se reativada, esse evento será acionado.
    def subscription_activated(data)
      # TODO
    end

    # Após uma assinatura ser suspensa, ela será tratada por este método.
    # Suspensa é diferente de expirada/cancelada.
    def subscription_suspended(data)
      subscription = ::Subscription.find_by(iugu_id: data[:id])
      subscription.update(suspended_on: Time.zone.now.to_date)
    end

    # Caso o cliente atrase o pagamento, a assinatura será suspensa e o Iugu
    # enviará esse evento para a gente.
    def subscription_expired(data)
      subscription = ::Subscription.find_by(iugu_id: data[:subscription_id])
      subscription.update(active: false)
    end

    # Evento para quando uma fatura for gerada.
    def invoice_created(data)
      subscription = ::Subscription.find_by(iugu_id: data[:subscription_id])

      unless subscription.nil?
        subscription.update(iugu_payment_status: data[:status])
      end
    end

    # Evento para quando o status de uma fatura referente a uma assinatura for
    # alterado.
    def invoice_status_changed(data)
      @subscription = ::Subscription.find_by(iugu_id: data[:subscription_id])
      @subscription.update(iugu_payment_status: data[:status])
    end
  end
end
