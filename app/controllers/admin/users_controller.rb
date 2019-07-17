class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: [:update, :destroy]
  def index
    @users = User.unscoped.order_by_time_desc.page(params[:page]).per(
      Settings.user_per_page
    )
  end

  def update
    @user.role = params[:role]
    if @user.save
      flash[:success] = t("controller.flash.update_role_successfully")
      respond_to do |format|
        format.html{redirect_to admin_users_path}
        format.js
      end
    else
      flash[:danger] = t("controller.flash.update_role_failed")
      redirect_to admin_users_path
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("controller.flash.destroy_user_successfully")
    else
      flash[:danger] = t("controller.flash.destroy_user_failed")
    end
    redirect_to admin_users_path
  end

  def recover
    puts "==========CONTROLLER#RECOVER: #{params[:id]}"
    if User.restore(params[:id])
      flash[:success] = "User Restore Successfully"
    else
      flash[:danger] = "User Restore Failed"
    end
    redirect_to admin_users_path
  end
  private

  def load_user
    @user = User.find_by_id params[:id]
    return true unless @user.nil?
    flash[:danger] = t("controller.flash.load_user_failed")
    redirect_to root_path
  end
end
