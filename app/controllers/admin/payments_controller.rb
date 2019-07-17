class Admin::PaymentsController < Admin::BaseController
  before_action :load_data, only: [:index]
  def index
    @sum = 0
    @bookings.each do |b|
      @sum += b.tour_detail.price
    end
  end

  private

  def load_data
    return time_present if params[:time_start].present?
    time_nil
  end

  def time_nil
    @bookings = Booking.joins(:payments).this_month.order_by_time_desc.page(
      params[:page]
    ).per(
      Settings.booking_per_page_admin
    )
  end

  def time_present
    @bookings = Booking.joins(:payments).this_month.order_by_time_desc.page(
      params[:page]
    ).per(
      Settings.booking_per_page_admin
    )
  end
end
