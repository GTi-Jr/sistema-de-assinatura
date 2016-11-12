class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  has_one    :baby

  accepts_nested_attributes_for :baby

  # Checa se a assinatura está ativa.
  #
  # Retorna true caso esteja ativa e falso C.C.
  def active?
    canceled_on.nil?
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
    Iugu::Subscription.fetch(subscription_id) if in_iugu?
  end
end
