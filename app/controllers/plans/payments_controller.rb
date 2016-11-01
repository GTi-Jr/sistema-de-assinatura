class Plans::PaymentsController < PlansController
  before_action :set_plan, except: [:confirm_payment]

  def checkout
  end

  def paypal_checkout
    subscription = @plan.subscriptions.build

    redirect_to subscription.paypal.checkout_url(
      return_url: plans_paypal_confirm_url(@plan.id),
      cancel_url: root_url,
      ipn_url:    'www.teste.com.br'
    )
  end

  def confirm
    @subscription = @plan.subscriptions.build
    @subscription.build_baby
    @subscription.paypal_payment_token = params[:token]
    @subscription.paypal_customer_token = params[:PayerID]
  end

  def confirm_payment
    @subscription = Subscription.new(subscription_params)
    @subscription.user = current_user

    if @subscription.save_with_paypal
      redirect_to user_profile_path, notice: "Obrigado por assinar #{@subscription.plan.name}"
    else
      render :confirm
    end
  end

  private
  def set_plan
    @plan = Plan.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:plan_id, :paypal_payment_token, :paypal_customer_token, baby_attributes: %i(name born birthdate weeks))
  end
end
