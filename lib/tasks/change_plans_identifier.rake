namespace :seed do
  task :change_plans_identifier => :environment do
    Plan.find(1).update_columns(plan_identifier: 'plan_1')
    Plan.find(2).update_columns(plan_identifier: 'plan_2')
    Plan.find(3).update_columns(plan_identifier: 'plan_3')
  end
end
