class HomeController < ApplicationController
  def index; end

  def search_kits
    @product_kits = ProductKit.search(params[:q]).uniq
  end
end
