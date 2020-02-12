class CarrierOptionsController < ApplicationController


  def new
    @carrier = Carrier.find(params[:id])
    @carrier_option = CarrierOption.new
  end

  def create
    @carrier_option = CarrierOption.new(carrier_option_params)
    if @carrier_option.save!
      redirect_to @carrier_option, notice: 'Opção de frete cadastrada com sucesso'
    else
      render :new
    end
  end

  private

  def carrier_option_params
    params.require(:carrier_option).permit(:min_vol, :max_vol, :price_kg, :carrier_id)
  end
end
