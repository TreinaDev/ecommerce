class CarrierOptionsController < ApplicationController
  def new
    @carrier_option = CarrierOption.new
    @carrier = Carrier.find(params[:carrier_id])
  end

  def edit
    @carrier_option = CarrierOption.find(params[:id])
  end

  def update
    @carrier_option = CarrierOption.find(params[:id])
    @carrier = @carrier_option.carrier
    if @carrier_option.update(carrier_option_params)
      redirect_to @carrier, notice: t('flash.update', model: 'Opção de frete')
    else
      render :edit
    end
  end

  def create
    @carrier = Carrier.find(params[:carrier_id])
    @carrier_option = CarrierOption.new(carrier_option_params)
    @carrier_option.carrier = @carrier
    if @carrier_option.save
      redirect_to @carrier, notice: t('flash.success', model: 'Opção de frete')
    else
      render :new
    end
  end

  def destroy
    @carrier_option = CarrierOption.find(params[:id])
    @carrier = @carrier_option.carrier
    @carrier_option.destroy
    redirect_to @carrier, notice: t('flash.destroy', model: 'Opção de frete')
  end

  private

  def carrier_option_params
    params.require(:carrier_option).permit(:min_vol, :max_vol,
                                           :price_kg, :carrier_id)
  end
end
