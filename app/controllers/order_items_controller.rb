class OrderItemsController < ApplicationController
  before_action :authenticate_client!
  before_action :retrieve_user_order, only: %i[create]

  def create
    @order_item = OrderItem.new(order_item_params)
    if @order_item.save
      flash[:notice] = 'Adicionado ao carrinho'
      @order_item.update_total_value
    else
      flash[:alert] = 'Tente novamente'
    end
    redirect_to @order_item.product_kit
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    if @order_item.destroy
      flash[:notice] = 'Item removido'
      @order_item.update_total_value
    end
    redirect_to cart_path
  end

  private

  def retrieve_user_order
    @order = current_client.orders.find_by(status: :pending)
    return if @order

    @order = Order.create(client: current_client)
  end

  def order_item_params
    params.permit(:product_kit_id).merge(order: @order)
  end
end
