class WelcomeController < ApplicationController
  def home
    @plans = Plan.order(:price)
  end
end
