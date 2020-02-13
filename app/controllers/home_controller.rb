class HomeController < ApplicationController
  def index; end

  def search_kits
    @product_kits = []
    kit_name = ProductKit.where('lower(name) = ?', params[:q].downcase)
    product_name = ProductKit.joins(:products)
                             .where('lower(products.name) = ?',
                                    params[:q].downcase)
    @product_kits << kit_name if kit_name.present?
    @product_kits << product_name if product_name.present?
    @product_kits.uniq
  end
end
