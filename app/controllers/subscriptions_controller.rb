class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]


  def index
    @subscriptions = Subscription.all
  end

  def show
  end


  def new
    @user= User.find(params[:id])
    @subscription = @user.build_subscription
  end

  def edit
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:canceled_on,:subscription_code,:user_id,:plan_id)
    end
end
