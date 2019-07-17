class Admin::BookingsController < Admin::BaseController
  before_action :load_booking, only: :destroy
  def index
    @booking = Booking.order_by_time_desc.page(
      params[:page]
    ).per(
      Settings.booking_per_page_admin
    )
  end

  def destroy
    if @booking.destroy
      flash[:success] = t("controller.flash.destroy_booking_successfully")
    else
      flash[:danger] = t("controller.flash.destroy_booking_failed")
    end
    redirect_to admin_bookings_path
  end

  private

  def load_booking
    @booking = Booking.find_by_id params[:id]
    return if @booking
    flash[:danger] = t("controller.flash.load_booking_failed")
    redirect_to root_path
  end
end
