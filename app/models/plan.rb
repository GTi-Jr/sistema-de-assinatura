class Plan < ActiveRecord::Base
  validates_uniqueness_of :identifier

  before_create :create_in_iugu
  before_save   :save_in_iugu

  has_many :subscriptions
  has_many :users, through: :subscriptions


  # no-doc
  def price_per_month
    price/duration.to_f
  end

  # no-doc
  def price_in_cents
    price * 100
  end

  def iugu_object
    @iugu_api_object ||= Iugu::Plan.fetch_by_identifier(identifier)
  end

  private

  # Logo após criar um plano, fazemos uma request para o Iugu criar um plano na
  # de dados deles.
  # Caso não dê certo, o plano nao será criado localmente.
  #
  # before_create :create_in_iugu
  def create_in_iugu
    plan = Iugu::Plan.create({
      name: name,
      identifier: identifier,
      interval: duration,
      interval_type: 'months',
      value_cents: price_in_cents,
      payable_with: 'credit_card',
      currency: 'BRL'
    })

    return false unless plan.errors.nil?

    self.iugu_id = plan.id
  end

  # Sempre que tentarmos atualizar os dados de um plano, faremos uma request
  # para o Iugu atualizar na base de dados deles. Caso não seja possível salvar
  # lá retornará falso e não será possivel salvar localmente.
  #
  # Retorna true se for possível salvar e falso C.C.
  #
  # before_save :save_in_iugu
  def save_in_iugu
    unless new_record?
      iugu_object.name= name
      iugu_object.interval = duration
      iugu_object.identifier = identifier
      iugu_object.value_cents = price_in_cents
      iugu_object.save
    end
  end
end
