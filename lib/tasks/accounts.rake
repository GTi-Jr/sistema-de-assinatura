namespace :accounts do
  desc "TODO"
  task generate: :environment do
    CSV.foreach(Rails.root.join("db/csv/emails.csv"), headers: false) do |row|
      @token= Devise.friendly_token
      generated_password = Devise.friendly_token.first(8)
      user = User.create!(email: row[0],password: generated_password)#, reset_password_token: @token)

      user.send_reset_password_instructions
      #Devise::Mailer.reset_password_instructions(user,@token).deliver

    end
  end

end
