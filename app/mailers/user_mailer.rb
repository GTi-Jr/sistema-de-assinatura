class UserMailer < ApplicationMailer

  def send_mail_to_admin(user)
    @user = user
    # mail to: 'contato@caixadacegonha.com.br',
    mail to: 'contato@caixadacegonha.com.br',
    subject: "Usuário #{user.name} acaba de confirmar pagamento"
    # from: user.email
  end

  def send_mail_to_user(user)
    @user = user
    mail to: user.email,
    subject: "Sua inscrição acaba de ser confirmada.",
    from: 'contato@caixadacegonha.com.br'
  end

end
