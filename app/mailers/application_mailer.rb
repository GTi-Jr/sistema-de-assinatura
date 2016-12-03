class ApplicationMailer < ActionMailer::Base
  include ::SendGrid if Rails.env.production?
  default from: 'contato@caixadacegonha.com.br'
  layout 'mailer'
end
