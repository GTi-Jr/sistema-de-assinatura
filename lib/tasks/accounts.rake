namespace :accounts do
  desc 'Task para pegar usuários de uma planilha CSV e cadastrá-los'
  task generate: :environment do
    CSV.foreach(Rails.root.join("db/csv/accounts.csv"), headers: false) do |row|
      password = ENV['PASSWORD']
      p "Seeding #{row[1]}"
      user = User.create(name: row[0],
                   email: row[1],
                   phone: row[2],
                   password: password,
                   discount: 30) # Ativa o desconto para esses usuários

      if user.errors.empty?
        UserMailer.notice_discount(user, password).deliver_now
      else
        p user.errors.full_messages
      end
    end
  end

end
