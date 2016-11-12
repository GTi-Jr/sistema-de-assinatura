class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  has_one    :baby

  accepts_nested_attributes_for :baby

  scope :active, -> { where.not(suspended_on: nil) }
  scope :suspended, -> { where(suspended_on: nil) }

  # Checa se a assinatura está ativa.
  #
  # Retorna true caso esteja ativa e falso C.C.
  def active?
    !suspended_on.nil?
  end

  # Suspende a assinatura e atualiza
  def suspend!
    if iugu_object
      if iugu_object.suspend
        update(suspended_on: Time.zone.now.to_date)
      else
        fetch_api_errors(iugu_object.errors)
      end
    end
  end

  # Checa se o objeto já está associado ao seu respectivo na base de dados do
  # Iugu.
  #
  # Retorna true caso esteja associado e falso C.C.
  def in_iugu?
    !!subscription_id
  end

  # Retorna o objeto presente no banco de dados do Iugu. Caso não tenha,
  # retorna nil
  def iugu_object
    @iugu_obj ||= Iugu::Subscription.fetch(subscription_id) if in_iugu?
  end

  private

  # Pega um array de erros das API e coloca no objeto.
  # ==== Exemplos
  #   subscription = Subscription.find(id)
  #   
  #   if subscription.suspend
  #     # código para caso a requisição dê certo.
  #   else
  #     subscription.fetch_api_errors(subscription.iugu_object.errors)
  #     subscription.errors.full_messages #=> ['Error 1', 'Error 2']
  #   end
  def fetch_api_errors(api_errors)
    api_errors.each { |error| errors[:base] << error }
  end
end
