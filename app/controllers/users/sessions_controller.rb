class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end


  protected

  # TODO mudar a rota para o perfil da pessoa ou algo do tipo
  def after_sign_in_path_for(resource)
    current_user.complete ? user_profile_path : after_registration_path
    UserMailer.send_mail_to_user(current_user).deliver_now
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
