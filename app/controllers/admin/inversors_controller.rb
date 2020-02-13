class Admin::InversorsController < ApplicationController
  before_action :authenticate_admin!

  def index; end

  def new
    @inversor = Inversor.new
  end

  def create
    @inversor = Inversor.new(inversor_params)
    if @inversor.save
      redirect_to admin_inversor_path(@inversor), notice: t('flash.success',
                                                            model: 'Inversor')
    else
      flash[:alert] = 'Não foi possivel cadastrar a placa solar'
      render :new
    end
  end

  def show
    @inversor = Inversor.find(params[:id])
  end

  private

  def inversor_params
    params.require(:inversor).permit(:name, :width, :height, :thickness,
                                     :weight, :purchase_price, :sku,
                                     :max_wattage, :max_voltage, :max_current)
  end
end
