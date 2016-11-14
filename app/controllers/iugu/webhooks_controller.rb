class Iugu::WebhooksController < ApplicationController
  protect_from_forgery with: :null_session

  # Controller para retorno da API do Iugu. Algumas mudanças no sistema deles
  # dispara eventos em novo sistema, mandando alguns parâmetros.
  #
  # https://iugu.com/referencias/gatilhos
  def webhook
    # TODO Utilizar Iugu::WebhooksHandler após concluído
    if params[:key] == 'cegonha_caixa_gti'
      case params[:event]
      when 'subscription.created'   then subscription_created
      when 'subscription.activated' then subscription_activated
      when 'subscription.suspended' then subscription_suspended
      when 'subscription.expired'   then subscription_expired
      when 'invoice.created'        then invoice_created
      when 'invoice.status_changed' then invoice_status_changed
      end
    end

    render nothing: true
  end

  private

  # Pega o evento de assinatura criada. A requisição de criação dela está em um
  # controller. Após ser criada no Iugu, eles mandarão uma mensagem para nosso
  # servidor e este método irá tratá-la.
  # Após criada lá, devemos criar uma assinatura referente em nossa base de dados.
  def subscription_created
    iugu_subscription = Iugu::Subscription.fetch(params[:data][:id])
    last_invoice      = iugu_subscription.recent_invoices[0]

    user = ::User.find_by(customer_id: iugu_subscription.customer_id)
    plan = ::Plan.find_by(identifier: iugu_subscription.plan_identifier)

    subscription = user.subscriptions.create do |subscription|
      subscription.plan                = plan
      subscription.iugu_id             = iugu_subscription.id
      subscription.iugu_payment_status = last_invoice['status']
      subscription.active              = iugu_subscription.active
      subscription.suspended_on        = Time.zone.now.to_date if iugu_subscription.suspended
    end

    subscription.build_baby(name: 'Nome do bebê', born: false).save
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
    subscription = ::Subscription.find_by(iugu_id: params[:data][:subscription_id])
    subscription.update(active: false)
  end

  # Evento para quando uma fatura for gerada.
  def invoice_created
    subscription = ::Subscription.find_by(iugu_id: params[:data][:subscription_id])

    unless subscription.nil?
      subscription.update(iugu_payment_status: params[:data][:status])
    end
  end

  # Evento para quando o status de uma fatura referente a uma assinatura for
  # alterado.
  def invoice_status_changed
    @subscription = ::Subscription.find_by(iugu_id: params[:data][:subscription_id])

    @subscription.update(status: params[:data][:status])
  end
end

