class PaymentOption
  attr_reader :name, :installments, :installments_value

  def initialize(name, installments, installments_value)
    @name = name
    @installments = installments
    @installments_value = installments_value
  end

  def self.all(_order_value)
    []
  end
end
