class WelcomeController < ApplicationController
  invisible_captcha only: [:contact_mail]

  def home
    @plans = Plan.order(:price)
    @plans2 = Iugu::Plan.search.results
  end

  def contact_mail
    redirect_to :back, alert: 'Insira um endereço de email' unless params[:email]
    redirect_to :back, alert: 'Insira uma mensagem' unless params[:message]
    redirect_to :back, alert: 'Insira seu nome' unless params[:name]
    ContactMailer.contact_email(params[:name], params[:email], params[:message]).deliver_now
    redirect_to :back, notice: 'Mensagem enviada!'
  end
end
