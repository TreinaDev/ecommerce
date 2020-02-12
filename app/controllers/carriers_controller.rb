class CarriersController < ApplicationController

  def index
    @carriers = Carrier.all
  end

  def new
    @carrier = Carrier.new
    @carrier.build_address
  end

  def create
    @carrier = Carrier.new(carrier_params)
    if @carrier.save
      redirect_to @carrier, notice: 'Transportadora cadastrada com sucesso'
    else
      render :new
    end
  end

  def show
    @carrier = Carrier.find(params[:id])
  end

  private

  def carrier_params
    params.require(:carrier)
          .permit(:name, :cnpj, :corporate_name,
                  address_attributes: %i[id street number complement zip_code
                                         neighborhood city state])
  end
end
