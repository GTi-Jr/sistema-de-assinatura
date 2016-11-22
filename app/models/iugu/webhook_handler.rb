module Iugu::WebhookHandler
  # Processa o evento que é passado através de requisições post pelo Iugu.
  # Seja um evento chamado 'invoices.created', este método procurará pelo método
  # :invoices_created dentro deste módulo. Cada método usará a variável @data.
  # ==== Exemplos
  #   # Dentro de seu controller:
  #
  #   Iugu::WebhookHandler.process(params[:event], params[:data])
  def process(event, data = {})
    method = event.gsub('.', '_').to_sym
    @data  = data
    self.send(method, [data])
  end

  private

  # Pega o evento de assinatura criada. A requisição de criação dela está em um
  # controller. Após ser criada no Iugu, eles mandarão uma mensagem para nosso
  # servidor e este método irá tratá-la.
  # Após criada lá, devemos criar uma assinatura referente em nossa base de dados.
  def subscription_created
    iugu_subscription = Iugu::Subscription.fetch(@data.fetch(:subscription_id))
    last_invoice      = iugu_subscription.recent_invoices[0]

    @user = User.find_by(customer_id: iugu_subscription.customer_id)

    @subscription = @user.subscriptions.create(
      plan: @plan,
      iugu_id: iugu_subscription.id,
      iugu_payment_status:  last_invoice['status']
    )
  end

  # Uma assinatura pode ser suspensa. Após se reativada, esse evento será acionado.
  def subscription_activated
  end

  # Após uma assinatura ser suspensa, ela será tratada por este método.
  # Suspensa é diferente de expirada/cancelada.
  def subscription_suspended
  end

  # Caso o cliente atrase o pagamento, a assinatura será suspensa e o Iugu
  # enviará esse evento para a gente.
  def subscription_expired
  end

  # Evento para quando uma fatura for gerada.
  def invoice_created
    @subscription = Subscription.find_by(iugu_id: @data.fetch(:subscription_id))

    unless @subscription.nil?
      @subscription.update(status: @data.fetch(:status))
    end
  end

  # Evento para quando o status de uma fatura referente a uma assinatura for
  # alterado.
  def invoice_status_changed
    @subscription = Subscription.find_by(iugu_id: @data.fetch(subscription_id))

    unless @subscription.nil?
      @subscription.update(status: @data.fetch(:status))
    end
  end
end
