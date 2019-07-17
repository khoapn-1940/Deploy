class PagesController < ApplicationController
  def home
    authorize! :read, TourDetail
    @search = Tour.ransack(params[:q])
    @tour_details = TourDetail.order_by_time_desc.page(
      params[:page]
    ).per(
      Settings.index_per_page
    )
  end

  def search
    authorize! :read, TourDetail
    get_data
    @tour_details = TourDetail.where(
      tour_id: @tour.ids
    ).order_by_time_desc.page(params[:page]).per(Settings.index_per_page)
    render :home
  end

  private

  def get_data
    Tour.ransack(params[:q])
    @search = Tour.ransack(name_cont: params[:q][:name])
    @tour = @search.result
    @tour = @tour.or(
      Tour.ransack(description_cont: params[:q][:name]).result
    )
  end
end
