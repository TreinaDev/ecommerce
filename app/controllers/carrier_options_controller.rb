class CarrierOptionsController < ApplicationController
  def new
    @carrier_option = CarrierOption.new
    @carrier = Carrier.find(params[:carrier_id])
  end


  def edit
    @carrier_options = CarrierOption.all
  end

  def update
    @carrier = Carrier.find(params[:carrier_id])
    if  @carrier_option(carrier_option_params)
      redirect_to @carrier, notice: 'Opção de frete atualizada com sucesso'
    else
      render :edit
    end
  end

  def create
    @carrier = Carrier.find(params[:carrier_id])
    @carrier_option = CarrierOption.new(carrier_option_params)
    @carrier_option.carrier = @carrier
    if @carrier_option.save
      redirect_to @carrier, notice: 'Opção de frete cadastrada com sucesso'
    else
      render :new
    end
  end

  def destroy
    @carrier.destroy
    redirect_to @carrier, notice: "Opção de frete excluida com sucesso"
  end

  private

  def carrier_option_params
    params.require(:carrier_option).permit(:min_vol, :max_vol,
                                           :price_kg, :carrier_id)
  end
end
