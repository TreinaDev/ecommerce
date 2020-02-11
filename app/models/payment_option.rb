class PaymentOption
  attr_reader :name, :installments, :installments_value

  def initialize(name, installments, installments_value)
    @name = name
    @installments = installments
    @installments_value = installments_value
  end

  def self.all(_order_value)
    response = Faraday.get('localhost:4000/api/v1/payment_options?order_value=100')
    json = JSON.parse(response.body, symbolize_names: true)

    if json.any?
      result = []

      json.each do |j|
        po = PaymentOption.new(j[:name], j[:installments].to_i, j[:installments_value].to_d)
        result << po
      end

      result
    else
      
    end
  end
end
