namespace :seed do
  task :change_plans_identifier => :environment do
    Plan.first.update_columns(plan_identifier: 'plan_1')
    Plan.second.update_columns(plan_identifier: 'plan_2')
    Plan.third.update_columns(plan_identifier: 'plan_3')
  end
end
