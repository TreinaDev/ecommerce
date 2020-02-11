class Admin::ProductKitsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @product_kits = ProductKit.all
  end

  def new
    @product_kit = ProductKit.new
  end

  def create
    @product_kit = ProductKit.new(product_kit_params)
    if @product_kit.save
      flash[:notice] = t('flash.success', model: 'Kit de produtos')
      redirect_to admin_product_kit_path(@product_kit)
    else
      flash[:alert] = t('flash.error', model: 'Kit de produtos')
      render :new
    end
  end

  def show
    @product_kit = ProductKit.find(params[:id])
    @kit_items = KitItem.where(product_kit: @product_kit)
  end

  private

  def product_kit_params
    params.require(:product_kit).permit(:name, :width, :height, :thickness,
                                        :weight, :price, :description,
                                        :picture, :warranty)
  end
end
