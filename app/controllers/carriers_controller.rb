class CarriersController < ApplicationController

  def new
    @carrier = Carrier.new
  end

  def create
    @carrier = Carrier.new(carrier_params)
    if @carrier.save
      redirect_to @carrier, notice: 'Transportadora cadastrada com sucesso'
    end
  end

  def show
    @carrier = Carrier.find(params[:id])
  end

  private
    def carrier_params
      params.require(:carrier).permit(:name, :cnpj, :corporate_name, :address)
    end
end