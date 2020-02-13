class Admin::KitItemsController < ApplicationController
  def new
    @products = Product.all.order(:type)
    @kit_item = KitItem.new
  end

  def create
    @kit_item = KitItem.new(kit_item_params)
    if @kit_item.save
      flash[:notice] = t('flash.add', model: 'Produto')
      redirect_to admin_product_kit_path(@kit_item.product_kit)
    else
      @products = Product.all.order(:type)
      flash[:alert] = t('flash.error', model: 'produto ao kit')
      render :new
    end
  end

  private

  def kit_item_params
    params.require(:kit_item).permit(:product_id, :quantity)
          .merge(product_kit_id: params[:product_kit_id])
  end
end
