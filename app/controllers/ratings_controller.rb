class RatingsController < ApplicationController
  before_action :load_rating, only: [:new]
  load_and_authorize_resource
  def create
    load_rating
    if @rating = current_user.ratings.create(
      star: params[:star], tour_id: params[:tour_id]
    )
      respond_to do |format|
        format.html{redirect_to root_path}
        format.js
      end
    else
      flash[:danger] = t("controller.flash.error")
    end
  end

  private
  def load_rating
    return if current_user.ratings.find_by(tour_id: params[:tour_id]).nil?
    flash[:danger] = t("controller.flash.error")
    redirect_to root_path
  end
end
