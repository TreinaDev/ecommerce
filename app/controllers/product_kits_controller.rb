class ProductKitsController < ApplicationController
  def index
    @product_kits = ProductKit.all
  end

  def show
    @product_kit = ProductKit.find(params[:id])
    @kit_items = KitItem.where(product_kit: @product_kit)
  end
end
