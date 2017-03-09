class UserMailer < ApplicationMailer

  def send_mail_to_admin(user)
    # mail to: 'contato@caixadacegonha.com.br',
    mail to: 'lucas64_64@hotmail.com',
    subject: "Usuário #{user.name} acaba de se cadastrar",
    from: user.email
  end

  def send_mail_to_user(user)
    mail to: user.email,
    subject: "Sua inscrição acaba de ser confirmada.",
    from: 'contato@caixadacegonha.com.br'
  end

end
