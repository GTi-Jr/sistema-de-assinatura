class Plan < ActiveRecord::Base

  belongs_to :subscription
  has_many :subscriptions
  has_many :users, through: :subscriptions

  def price_per_month
    price/duration.to_f
  end



  def create_iugu_plan


    if iugu_plan_id.blank?

      plan_iugu=Iugu::Plan.create({
          name: plan.name,
          identifier: "#{plan.name}_plan" ,
          interval: 1,
          interval_type: 'months',
          value_cents: (plan.price*100),
          payable_with: 'credit_card',

          })
      plan.iugu_plan_id = plan_iugu.id
      binding.pry
      if plan.save
        'Plano Criado com Sucesso'
      else
        'Erro na Criação'
      end

    else
      "Plano ja foi criado"
    end

  end



end
