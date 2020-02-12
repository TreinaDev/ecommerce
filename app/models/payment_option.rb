class PaymentOption
  attr_reader :name, :installments, :installments_value

  def initialize(name, installments, installments_value)
    @name = name
    @installments = installments
    @installments_value = installments_value
  end

  def self.all(_order_value)
    json = call_api('localhost:4000/api/v1/payment_options?order_value=100')
    result = []
    return result if response.status == 500

    json.each do |j|
      po = PaymentOption.new(j[:name], j[:installments].to_i,
                             j[:installments_value].to_d)
      result << po
    end
    result
  end

  def call_api(url)
    response = Faraday.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
