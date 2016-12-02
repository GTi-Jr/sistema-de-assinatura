class User < ActiveRecord::Base
  @@max_addresses_number = 3

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  # Permite validações em cima do atributo cpf. Só será possível salvar o objeto
  # caso o cpf seja um número válido.
  usar_como_cpf :cpf

  # Relacionamentos
  has_many :addresses
  has_many :subscriptions, -> { active }
  has_many :suspended_subscriptions, -> { suspended }, class_name: 'Subscription'
  has_many :plans, through: :subscriptions

  # Atributos conjuntos
  accepts_nested_attributes_for :addresses

  # Validações
  validates :addresses, length: { maximum: @@max_addresses_number }

  # Callbacks
  #before_create :create_in_iugu
  #before_save   :save_in_iugu
  after_save    :subscribe_user_to_mailing_list

  def owns_subscription?(subscription)
    subscriptions.include?(subscription)
  end

  def has_any_subscription?
    !subscriptions.empty?
  end

  def addresses_full?
    addresses.count >= @@max_addresses_number
  end

  def main_address
    addresses.find_by main: true
  end

  def has_any_address?
    addresses.any?
  end

  def babies_full?
    babies.count >= @@max_babies_number
  end

  def cancel_subscription(subscription)
    if subscriptions.include?(subscription)
      subscription.cancel_with_paypal!
    else
      false
    end
  end

  def subscribe_to_plan(plan)
    if plan.nil?
      return update(plan: plan)
    end
    false
  end

  def first_name
    name ? name.split(' ').first : ''
  end

  def last_name
    name ? name.split(' ').last : ''
  end

  def female?
    sex == 'F'
  end

  def any_subscriptions?
    !subscriptions.empty?
  end

  def customer
    unless customer_id
      customer = Iugu::Customer.create({ email: email, name: name }) rescue false
      update_attribute :customer_id, customer.id
      return customer
    end

    Iugu::Customer.fetch(customer_id) rescue nil
  end

  # Retora o objeto do usuário que está presente na base de dados do Iugu.
  def iugu_customer
    @customer ||= Iugu::Customer.fetch(customer_id)
  end

  def payment_methods
    Iugu::PaymentMethod.search({customer_id: customer_id}).results rescue []
  end

  def invoices
    Iugu::Invoice.search( customer_id: customer_id ).results rescue []
  end

  protected

  # Logo antes do cadastro, enviar email do usuário para o MailChimp.
  #
  # before_save : subscribe_user_to_mailing_list
  def subscribe_user_to_mailing_list
    SubscribeUserToMailingListJob.perform_later(id)
  end

  # Logo após o usuário se cadastrar adiciona o adiciona na base de dados do
  # Iugu e associamos o customer_id de lá ao nosso banco de dados para podermos
  # acessá-lo depois.
  #
  # before_create :create_in_iugu
  def create_in_iugu
    customer = Iugu::Customer.create({
      email: email,
      name: name
    })

    self.customer_id = customer.id
  end

  # Sempre que formos atualizar os dados do usuário localmente, devemos mantê-los
  # atualizados com os dados no Iugu.
  #
  # before_save :save_in_iugu
  def save_in_iugu
    unless new_record?
      iugu_customer.name     = name if name
      iugu_customer.email    = email if email
      iugu_customer.cpf_cnpj = cpf.to_s if cpf
      iugu_customer.save
    end
  end
end
