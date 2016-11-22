class Mailsender < ApplicationMailer
  def custom_email(user, title, body)
    mail to: user.email, subject: title, body: body, content: 'text/html'
  end
end
