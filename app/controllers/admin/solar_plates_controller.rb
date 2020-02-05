class Admin::SolarPlatesController < ApplicationController
  def index; end

  def new
    @solar_plate = SolarPlate.new
  end

  def create
    @solar_plate = SolarPlate.new(solar_plate_params)
    @solar_plate.save
    flash[:notice] = 'Placa solar cadastrada com sucesso'
    redirect_to admin_solar_plate_path(@solar_plate) 
  end

  def show
    @solar_plate = SolarPlate.find(params[:id])
  end

  private

  def solar_plate_params
    params.require(:solar_plate).permit(:name, :width, :height, :thickness, 
                                        :weight, :purchase_price, :sku, 
                                        :efficiency, :rated_power)
  end
end