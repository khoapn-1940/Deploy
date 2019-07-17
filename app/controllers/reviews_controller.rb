class ReviewsController < ApplicationController
  before_action :load_comment, only: :destroy
  def create
    authorize! :create, Review
    @comment_tour = current_user.reviews.create(comment_params)
    if @comment_tour.save
      respond_to do |format|
        format.html{redirect_to root_path}
        format.js
      end
    else
      flash[:danger] = t "controller.flash.comment_failed"
      redirect_to root_path
    end
  end

  def destroy
    authorize! :destroy, Review
    delete_my_review_method
  end
  private

  def load_comment
    @my_review = current_user.reviews.find_by_id params[:id]
    return if @my_review
    flash[:danger] = t "controller.flash.load_comment_failed"
    redirect_to view_my_review_path
  end

  def comment_params
    params.require(:review).permit :content, :tour_id
  end

  def delete_my_review_method
    if @my_review.destroy
      respond_to do |format|
        format.html{redirect_to view_my_booking_path}
        format.js
      end
    else
      flash[:danger] = t "controller.flash.delete_review_failed"
      redirect_to view_my_review_path
    end
  end
end
