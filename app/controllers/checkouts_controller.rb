class CheckoutsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def checkout
    if params[:identifier]
      @plan = Iugu::Plan.fetch_by_identifier(params[:identifier]) rescue nil
    end
    @payment_method = "credit_card"
  end

  def subscribe_to_plan
    customer = current_user.customer
    binding.pry
    if params[:payment_method] == "credit_card"
      customer.payment_methods.create({
        description: "Cartão de Crédito",
        token: params[:credit_card_token],
        set_as_default: true
      })
    end

    sub_params = {
      plan_identifier: params[:plan_identifier],
      customer_id: customer.id
    }
    sub_params[:only_on_charge_success] = true if params[:payment_method] == "credit_card"

    subscription = Iugu::Subscription.create(sub_params)
    binding.pry
    if subscription.errors
      @plan = Iugu::Plan.fetch_by_identifier(params[:plan_identifier])
      @payment_method = params[:payment_method]
      @error = "Erro na Cobrança!"
      return render root
    end

    current_user.subscription_id = subscription.id
    current_user.save

    redirect_to root_path
  end


  def pay
    param = (params[:token].empty? ? "method" : "token").to_sym
    binding.pry
    charge = Iugu::Charge.create({
      param => params[param],
      email: "matheuss3@email.com",
      items: [
        {
          description: "Item 1",
          quantity: "1",
          price_cents: "5990"
        },
        {
          description: "Item 2",
          quantity: "1",
          price_cents: "4000"
        }
      ]
    })

        binding.pry

    if charge and charge.success
      redirect_to root_path, notice: 'Sucesso'
    else
      redirect_to root_path, notice: 'Falha'
    end
  end

  def pay_subscription

  end

end
