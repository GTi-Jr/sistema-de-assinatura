class WelcomeController < ApplicationController
  invisible_captcha only: [:contact_mail]

  def home
    @plans = Plan.order(:price)
  end

  def contact_mail
    ContactMailer.contact_email(params[:name], params[:email], params[:message]).deliver_now
    redirect_to :back, notice: 'Mensagem enviada!'
  end
end
