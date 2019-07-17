class Admin::ReviewsController < Admin::BaseController
  before_action :load_review, only: [:destroy]

  def index
    @reviews = Review.order_by_time_desc.page(params[:page]).per(
      Settings.review_per_page_admin
    )
  end

  def destroy
    if @review.destroy
      flash[:success] = t("controller.flash.delete_review_successfully")
      respond_to do |format|
        format.html{redirect_to admin_users_path}
        format.js
      end
    else
      flash[:danger] = t("controller.flash.delete_review_failed")
      redirect_to root_path
    end
  end

  private

  def load_review
    @review = Review.find_by_id params[:id]
    return if @review
    flash[:danger] = t("controller.flash.load_review_failed")
    redirect_to root_path
  end
end
