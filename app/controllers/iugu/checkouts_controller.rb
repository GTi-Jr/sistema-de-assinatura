class Iugu::CheckoutsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  before_action :authenticate_user!
  before_action :set_plan, only: [:checkout]
  before_action :set_subscription , only: [:suspend]

  def checkout

    year = Date.today.year
    month = Date.today.month
    day = Date.today.day
    if day > 25 && month && month == 12
      month=1
      year= year+1

    elsif day > 25
      month= month+1
    end


    expires = Date.new(year,month,25)
    iugu_subscription = Iugu::Subscription.create({
      plan_identifier: @plan.identifier,
      customer_id:     current_user.customer_id,
      expires_at: expires
    })

    if iugu_subscription.errors.nil?
      redirect_to iugu_subscription.recent_invoices.first['secure_url']
    else
      redirect_to user_profile_path, alert: 'Não foi possível proceder para assinatura'
    end
  end

  def save_credit_card
    if params[:token]

      customer = Iugu::Customer.fetch(current_user.customer_id)

      payment=customer.payment_methods.create({
        description: "Primeiro Cartão",
        item_type: "credit_card",
        token: params[:token]

        })
      binding.pry
      redirect_to user_profile_path

    end
  end

  def suspend
    iugu_subscription = Iugu::Subscription.fetch(@subscription.iugu_id)
    iugu_subscription.suspended = true

    if iugu_subscription.save
      redirect_to user_profile_path, notice: 'Plano Suspenso'
    else
      redirect_to user_profile_path, notice: 'Tente novamente'
    end
  end

  private

  def set_plan
    @plan = ::Plan.find_by(identifier: params[:plan_identifier])
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

end
