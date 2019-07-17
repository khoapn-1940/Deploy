class LikesController < ApplicationController
  before_action :load_like, only: [:destroy]
  load_and_authorize_resource
  def create
    @like = current_user.likes.create(review_id: params[:id])
    if @like.save
      @like_count = @like.review.likes.count
      respond_to do |format|
        format.html{redirect_to root_path}
        format.js
      end
    else
      flash[:danger] = t("controller.flash.like_error")
      redirect_to root_path
    end
  end

  def destroy
    if @like.destroy
      @like_count = @like.review.likes.count
      destroy_success
    else
      destroy_failed
    end
  end

  private

  def load_like
    @like = current_user.likes.find_by(review_id: params[:id])
    return if @like
    flash[:danger] = t("controller.flash.unlike_error")
    redirect_to root_path
  end

  def destroy_success
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  def destroy_failed
    flash[:danger] = t("controller.flash.unlike_error")
    redirect_to root_path
  end
end
