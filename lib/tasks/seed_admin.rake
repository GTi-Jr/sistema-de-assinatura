
namespace :seed do
  task :seed_admin => :environment do
    Admin.create email: 'admin@caixadacegonha.com.br'
  end
end
