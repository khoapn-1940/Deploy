class BookingsController < ApplicationController
  before_action :load_booking, only: [:destroy]
  load_and_authorize_resource
  def create
    load_booking_tour_data
    handle_booking_tour
    redirect_to view_my_booking_path
  end

  def destroy
    if @my_booking.destroy
      respond_to do |format|
        format.html{redirect_to view_my_booking_path}
        format.js
      end
    else
      flash[:danger] = t "controller.flash.delete_failed"
      redirect_to view_my_booking_path
    end
  end

  private

  def load_booking
    @my_booking = current_user.bookings.find_by_id params[:id]
    return unless @my_booking.nil?
    flash[:danger] = t "controller.flash.delete_failed"
    redirect_to view_my_booking_path
  end

  def booking_params
    params.require(:booking).permit :book_total, :tour_detail_id
  end

  def load_booking_tour_data
    @tour_detail = TourDetail.find_by_id params[:booking][:tour_detail_id]
    @limit_booking = @tour_detail.tour_total
    @sum = @tour_detail.bookings.sum(:book_total)
    @booking_number = params[:booking][:book_total].to_i
    @payment = Payment.new
  end

  def handle_booking_tour
    if @sum + @booking_number > @limit_booking
      flash[:danger] =
        t("manage_booking.booking_request_controller.flash.tour_full",
          count: (@limit_booking - @sum))
    else
      book
    end
  end

  def book
    @booking_tour = current_user.bookings.create(booking_params)
    if @booking_tour.save
      price = params[:booking][:book_total].to_i * @tour_detail.price
      flash[:success] = t("controller.flash.booking_bill", price: price)
    else
      flash[:danger] = t "controller.flash.booking_failed"
    end
  end
end
