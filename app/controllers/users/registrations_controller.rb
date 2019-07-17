# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    authorize! :create, User
    super
  end

  # POST /resource
  def create
    authorize! :create, User
    super
  end

  # GET /resource/edit
  def edit
    authorize! :update, User
    super
  end

  # PUT /resource
  def update
    authorize! :update, User
    super
  end

  # DELETE /resource
  def destroy
    authorize! :destroy, User
    super
  end

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
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:name, :phone, :bank_account])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
      keys: [:name, :phone, :bank_account, :avatar])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  # private

  # def user_params
  #   params.require(:user).permit :name, :email, :phone, :bank_account,
  #     :password, :password_confirmation, :avatar
  # end
end
