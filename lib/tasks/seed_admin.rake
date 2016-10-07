namespace :seed do
  task :seed_admin => :environment do
    Admin.create email: 'admin@caixadacegonha.com.br', password: ENV['PASSWORD']
  end
end
