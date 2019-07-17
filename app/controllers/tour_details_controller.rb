class TourDetailsController < ApplicationController
  load_and_authorize_resource
  def show
    load_tour_details_data
    @reviews = @tour_detail.tour.reviews.order_by_time_desc.page(
      params[:page]
    ).per(
      Settings.tour_detail_reviews
    )
    @self_review = current_user.reviews.create(tour_id: params[:tour_id])
  end

  private
  def load_tour_details_data
    @tour_detail = TourDetail.find_by_id params[:id]
    @star = @tour_detail.tour.ratings.average(:star).to_i
    @booking_tour = current_user.bookings.create(
      tour_detail_id: params[:id]
    )
    @self_star = current_user.ratings.find_by(tour_id: params[:tour_id])
  end
end
