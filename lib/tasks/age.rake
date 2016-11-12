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



  desc 'Update weeks of babies'
  task update_weeks: :environment do

    babies= Baby.all

    babies.each do |baby|
      unless baby.born?
        if baby.weeks? && baby.birthdate?
          if Date.today > baby.birthdate + baby.weeks.week
            baby.weeks = (baby.weeks + 1)
            baby.save
          end
        end
      end

    end


  end

end
