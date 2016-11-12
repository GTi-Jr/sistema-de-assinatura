namespace :age do
  desc "Check the age of every baby"
  task get_ages: :environment do
    babies = Baby.all
    now= Date.today

    babies.each do |baby|
      age = baby.age

      unless age.blank?
        if age.day == now.day && age.month == now.month
          "Feliz #{age} anos"

        elsif age.to_i > 20
          puts "Maior de idade"
        end
      end
    end

  end

end
