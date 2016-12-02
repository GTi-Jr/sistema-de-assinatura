namespace :seed do
  task :seed_admin => :environment do
    Admin.where(email: 'admin@caixadacegonha.com.br').destroy_all
  end
end
