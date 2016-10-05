class ContactMailer < ApplicationMailer
  def contact_email(name, email, message)
    mail to: 'contato@caixadacegonha.com.br', 
         subject: "[SITE] - Email de #{email}",
         from: email,
         body: message,
         content: 'text/html'
  end
end
