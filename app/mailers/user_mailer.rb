class UserMailer < ApplicationMailer
  def notice_discount(user, password)
    @user = user
    @password = password
    mail to: user.email, subject: 'Bem vinda à Caixa da Cegonha!'
  end
end
