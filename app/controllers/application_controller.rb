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
    #redirect_to :back, alert: 'Ação indisponível no momento. Cheque mais tarde'
    redirect_to :back, alert: 'Obrigada! Seu cadastro está completo e você garantiu ' +
                              'seu desconto! Estamos muito felizes e em breve ' +
                              'entraremos em contato para você escolher seu plano.'
  end
end
