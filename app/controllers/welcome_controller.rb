class WelcomeController < ApplicationController
  invisible_captcha only: [:contact_mail]

  def home
    @user     = User.new unless user_signed_in? # Para form de login
    @new_user = User.new # Para formulário de cadastro
    @plans    = Plan.order(:price) # Para mostrar os planos
  end

  def contact_mail
    redirect_to :back, alert: 'Insira um endereço de email' unless params[:email]
    redirect_to :back, alert: 'Insira uma mensagem' unless params[:message]
    redirect_to :back, alert: 'Insira seu nome' unless params[:name]
    ContactMailer.contact_email(params[:name], params[:email], params[:message]).deliver_now
    redirect_to :back, notice: 'Mensagem enviada!'
  end
end
