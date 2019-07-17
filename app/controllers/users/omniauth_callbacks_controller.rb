class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authorize! :register, User
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.new_record?
      session["devise.facebook_data"] = request.env["omniauth.auth"]
    end
    flash[:success] = I18n.t "devise.omniauth_callbacks.success",
      kind: "Facebook"
    sign_in_and_redirect @user, event: :authentication
  end

  def google_oauth2
    authorize! :register, User
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.new_record?
      session["devise.google_data"] = request.env["omniauth.auth"]
    end
    flash[:success] = I18n.t "devise.omniauth_callbacks.success",
      kind: "Google"
    sign_in_and_redirect @user, event: :authentication
  end

  def failure
    redirect_to root_path
  end

  private

  def facebook_register
    @user = User.create!(email: session["devise.facebook_data"][:info][:email],
      name: session["devise.facebook_data"][:info][:name],
       password: "HelloSydney", uid: session["devise.facebook_data"][:uid],
       provider: "Facebook", phone: "123456789",
        bank_account: "123456789", role: :user)
  end

  def google_register
    @user = User.create!(email: session["devise.google_data"][:info][:email],
      name: session["devise.google_data"][:info][:name],
       password: "HelloSydney", uid: session["devise.google_data"][:uid],
       provider: "google_oauth2", phone: "123456789",
        bank_account: "123456789", role: :user)
  end
end
