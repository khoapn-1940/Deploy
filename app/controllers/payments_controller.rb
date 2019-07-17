class PaymentsController < ApplicationController
  def create
    authorize! :create, Payment
    @booking = current_user.bookings.find_by_id params[:payment][:booking_id]
    process_payment
    if @payment = @booking.payments.create(payment_params)
      pay_success
    else
      pay_fail
    end
  rescue Stripe::CardError => e
    flash[:danger] = e.message
    redirect_to view_my_booking_path
  end

  private

  def process_payment
    customer = Stripe::Customer.create email: params[:stripeEmail],
                                       card: params[:stripeToken]

    Stripe::Charge.create customer: customer.id,
                          amount: @booking.tour_detail.price.round(0),
                          description: @booking.tour_detail.tour.name,
                          currency: "usd"
  end

  def pay_success
    flash[:success] = t("controller.flash.payment_successfully")
    redirect_to view_my_booking_path
  end

  def pay_fail
    flash[:danger] = t("controller.flash.payment_failed")
    redirect_to view_my_booking_path
  end

  def payment_params
    params.require(:payment).permit :booking_id, :method, :content
  end
end
