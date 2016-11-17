class Subscription < BaseModel
  belongs_to :user
  belongs_to :plan
  has_one    :baby

  accepts_nested_attributes_for :baby

  validates_uniqueness_of :iugu_id

  scope :active, -> { where(suspended_on: nil) }
  scope :suspended, -> { where.not(suspended_on: nil) }

  # Enum para os status da última fátura referente à assinatura. As faturas são
  # atualizadas através da API do Iugu. Sempre que uma é gerada, o Iugu nos avisa
  # e atualizamos o status da assinatura em nossa base de dados.
  # Status possíveis:
  #
  # Draft
  # Pending
  # Partially_paid
  # Paid
  # Canceled
  # Refunded
  # Expired
  # Authorized
  enum iugu_payment_status: { draft: 0, pending: 1, partially_paid: 2, paid: 3, canceled: 4, refunded: 5, expired: 6, authorized: 7}

  # Checa se a assinatura está suspensa.
  #
  # Retorna false caso esteja ativa e true caso suspensa.
  def suspended?
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

  def set_new_expiry_date!
    set_new_expiry_date
    iugu_object.save
  end

  def set_new_expiry_date
    today_date = Time.zone.now.to_date

    day = today_date.day
    month = today_date.month
    year = today_date.year

    due_day = 25

    if day > due_day && month && month == 12
      month = 0 + subscription.plan.duration
      year = year + 1
    elsif day > due_day && (month + subscription.plan.duration) > 12
      month = (month + subscription.plan.duration) - 12
      year = year + 1
    elsif day > due_day
      month = month + subscription.plan.duration
    end

    new_expire_date = Date.new(year,month,25)
   
    iugu_object.expires_at = new_expire_date
  end

  # Checa se a assinatura está ativa.
  #
  # Obs: uma assinatura pode estar suspensa e ativa ao mesmo tempo. Isso
  # significa que ela foi suspensa, mas como já foi paga, ainda tem tempo de
  # serviço restante, logo, está ativa.
  def active?
    active
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

  # Altera o plano no qual a assinatura está atrelada. Tenta atualizar no Iugu
  # e, caso a requisição retorne status OK, alteramos e nossa base de dados.
  def change_plan(plan)
    iugu_object.plan_identifier = plan.identifier

    if iugu_object.save
      update(plan: plan)
    end
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
