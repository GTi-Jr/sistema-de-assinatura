class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def check_user_completed
    if current_user && !current_user.complete
      redirect_to after_registration_path, notice: 'Conclua seu cadastro.' 
    end
  end

  def block_actions
    redirect_to :back, alert: 'Ação indisponível no momento. Cheque mais tarde'
  end
end
