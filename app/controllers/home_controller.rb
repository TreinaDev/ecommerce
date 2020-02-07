class HomeController < ApplicationController
  def index
    @payment_options = PaymentOption.all()
  end
end
