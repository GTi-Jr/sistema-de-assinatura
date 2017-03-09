class UserMailer < ApplicationMailer

  def send_mail_to_admin(user)
    @user = user
    # mail to: 'contato@caixadacegonha.com.br',
    mail to: 'lucas64_64@hotmail.com',
    subject: "Usuário acaba de se cadastrar",
    from: user.email
  end

  def send_mail_to_user(user)
    @user = user
    mail to: user.email,
    subject: "Sua inscrição acaba de ser confirmada.",
    from: 'contato@caixadacegonha.com.br'
  end

end
