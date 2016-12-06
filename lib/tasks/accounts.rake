namespace :accounts do
  desc 'Task para pega usuários de uma planilha CSV e cadastrá-los'
  task generate: :environment do
    CSV.foreach(Rails.root.join("db/csv/emails.csv"), headers: false) do |row|
      password = ENV['PASSWORD']
      User.create!(name: row[0], 
                   email: row[1], 
                   password: password,
                   discount: true) # Ativa o desconto para esses usuários
    end
  end

end
