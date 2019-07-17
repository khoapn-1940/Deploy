class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, only: :destroy
  def index
    @categories = Category.order_by_time_desc.page(
      params[:page]
    ).per(
      Settings.category_per_page
    )
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t("controller.flash.category_created_successfully")
      redirect_to admin_categories_path
    else
      flash[:danger] = t("controller.flash.category_created_failed")
      render :new
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t("controller.flash.destroy_category_successfully")
    else
      flash[:danger] = t("controller.flash.destroy_category_failed")
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def load_category
    @category = Category.find_by_id params[:id]
    return if @category
    flash[:danger] = t("controller.flash.load_category_failed")
    redirect_to root_path
  end
end
