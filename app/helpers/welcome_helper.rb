module WelcomeHelper
  def greetings(user)
    message = user.female? ? 'Bem vinda' : 'Bem vindo'
    message << ", #{user.first_name || user.email}"
    message
  end
end
