class Plan < ActiveRecord::Base
  before_create :create_in_iugu
  before_save   :save_in_iugu

  has_many :subscriptions
  has_many :users, through: :subscriptions

  # no-doc
  def price_per_month
    price/duration.to_f
  end

  # Identificador do plano no Iugu. Substitui os espaços por "_" e deixa tudo
  # minúsculo.
  # ==== Exemplos
  #
  #   plan = Plan.new(name: 'Um plano')
  #   plan.identifier #=> "um_plano"
  def identifier
    name.gsub(/\s+/, "_").downcase
  end

  # no-doc
  def price_in_cents
    price * 100
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

    plan.errors.nil?
  end

  # Sempre que tentarmos atualizar os dados de um plano, faremos uma request
  # para o Iugu atualizar na base de dados deles. Caso não seja possível salvar
  # lá retornará falso e não será possivel salvar localmente.
  #
  # Retorna true se for possível salvar e falso C.C.
  #
  # before_save :save_in_iugu
  def save_in_iugu
    Iugu::Plan.save({
      name: name,
      identifier: identifier ,
      interval: duration,
      interval_type: 'months',
      value_cents: price_in_cents,
      payable_with: 'credit_card',
      currency: 'BRL'
    })
  end
end
