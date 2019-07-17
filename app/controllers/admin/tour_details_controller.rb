class Admin::TourDetailsController < Admin::BaseController
  before_action :load_tour_detail, only: [:destroy]
  def new
    @tour_details = current_user.tour_details.build(tour_id: params[:id])
  end

  def index
    @tour_details = TourDetail.t_id(params[:id]).order_by_time_desc.page(
      params[:page]
    ).per(
      Settings.tour_detail_per_page
    )
  end

  def create
    @tour_details = current_user.tour_details.create(user_params)
    if @tour_details.save
      flash[:success] = t("controller.flash.tour_detail_created_successfully")
      redirect_to admin_tour_details_path(id: params[:tour_detail][:tour_id])
    else
      flash[:danger] = t("controller.flash.tour_detail_created_failed")
      render :new
    end
  end

  def destroy
    if @tour_detail.destroy
      flash[:success] = t("controller.flash.delete_tour_detail_successfully")
    else
      flash[:danger] = t("controller.flash.delete_tour_detail_failed")
    end
    redirect_to admin_tours_path
  end

  private

  def user_params
    params.require(:tour_detail).permit(
      :price, :tour_total, :time_start, :time_end, :user_id, :tour_id
    )
  end

  def load_tour_detail
    @tour_detail = TourDetail.find_by_id params[:id]
    return if @tour_detail
    flash[:danger] = t("controller.flash.load_tour_detail_failed")
    redirect_to root_path
  end
end
