class Admin::KitItemsController < ApplicationController
  def new
    @products = Product.all.order(:type)
    @kit_item = KitItem.new
  end

  def create
    @kit_item = KitItem.new(kit_item_params)
    product = @kit_item.product
    product_kit = @kit_item.product_kit
    if @kit_item.save
      flash[:notice] = t('flash.add', model: product.model_name.human)
      redirect_to admin_product_kit_path(product_kit)
    end
  end

  private

  def kit_item_params
    params.require(:kit_item).permit(:product_id, :quantity)
          .merge(product_kit_id: params[:product_kit_id])
  end
end
