class HomeController < ApplicationController
  def index
    @product_kits = ProductKit.all
  end

  def search_kits
    @product_kits = ProductKit.search(params[:q]).uniq
  end
end
