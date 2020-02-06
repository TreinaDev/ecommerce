class Admin::SolarPlatesController < ApplicationController
  before_action :authenticate_admin!
  
  def index; end

  def new
    @solar_plate = SolarPlate.new
  end

  def create
    @solar_plate = SolarPlate.new(solar_plate_params)
    if @solar_plate.save
      flash[:notice] = t('flash.success', model: 'Placa solar')
      redirect_to admin_solar_plate_path(@solar_plate)
    else
      flash[:alert] = 'Não foi possivel cadastrar a placa solar'
      render :new
    end
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