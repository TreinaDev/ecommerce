class HomeController < ApplicationController
  def index; end

  def search_kits
    #product_kits = ProductKit.where('name = ?', params[:q])
    @product_kits = ProductKit.joins(:products)
                              .where('products.name = ?', params[:q])
  end
end
