class ApplicationMailer < ActionMailer::Base
  include SendGrid
  default from: 'naoresponda@caixadacegonha.com.br'
  layout 'mailer'
end
