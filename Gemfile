source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'coffee-rails'
#Utilizar o postgresql
gem 'pg', '~> 0.15'
# Servidor Puma
gem 'puma'
# Autenticação
gem 'devise'
# Coleção de gems para desenvolvedores brasileiros - cnpf, cpf, cep, traduções, numeros por extenso etc
gem 'brazilian-rails'
gem 'rails_admin_rollincode', '~> 1.0'
gem 'rails_admin', github: 'sferik/rails_admin'
# Mailchimp API
gem 'gibbon'
# Mostrar erros de produção
gem 'rollbar'
#Deploy na Amazon
gem 'figaro'
gem 'capistrano-rails-console', require: false
gem 'rails_12factor', group: :production
gem 'google-analytics-rails', '1.1.0'
# Prevenir spam
gem 'invisible_captcha'
# Ícones especiais
gem 'font-awesome-sass'
# Gem para modo de manutenção
gem 'turnout'
# Site map
gem 'dynamic_sitemaps'
# Slim para utilizar .slim em vez de .erb nas views
gem "slim-rails"
# Gem de pagamentos do Iugu
gem 'iugu'
# Funções que irão ser rodadasde tempos em tempos
gem 'whenever', require: false

group :development, :test do
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'byebug'
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'mailcatcher'
  #Deploy na Amazon
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm'
  gem 'pry'
  gem 'dotenv-rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
end

