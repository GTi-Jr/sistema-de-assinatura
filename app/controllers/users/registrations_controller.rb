class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
#
  def new
    super
  end

  def after_registration
    @user = current_user

    @user.babies.build
  end

  def complete_registration
    if current_user.update(after_registration_params)
      redirect_to root_path, notice: 'Informações salvas.'
    else
      render :after_registration
    end
  end

  def create
      build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end

    #sign_up('user',@user)
    #redirect_to :root


   # build_resource(sign_up_params)
    #resource= User.new
    #resource.save

    #redirect_to :root
  end


private
  def sign_up_params
  #  allow= user: {:email,:name,:sex,:birthdate,:cpf,:rg,:street,:number,:password, :password_confirmation, baby: {:name,:born}}
    params.require(:user).permit(:email,:password, :password_confirmation)
  end

  def after_registration_params
    params.require(:user).permit(:name, :sex, :birthdate, :phone, :cpf, :rg, babies_attributes: [:id,:user_id,:name,:born,:birthdate,:weeks])
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
   def after_sign_up_path_for(resource)
    after_registration_path
   end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
