namespace :seed do
  task :seed_plans => :environment do
    plan_1 = Plan.new name: 'Plano 1', duration: 1, price: 20
    plan_2 = Plan.new name: 'Plano 2', duration: 3, price: 50
    plan_3 = Plan.new name: 'Plano 3', duration: 6, price: 90

    plan_1.save
    plan_2.save
    plan_3.save
  end
end
