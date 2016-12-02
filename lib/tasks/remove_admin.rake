namespace :seed do
  task :destroy_admin => :environment do
    Admin.where(email: 'admin@caixadacegonha.com.br').destroy_all
  end
end
