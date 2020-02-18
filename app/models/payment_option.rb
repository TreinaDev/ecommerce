class PaymentOption
  attr_reader :name, :installments, :installments_value

  def initialize(name, installments, installments_value)
    @name = name
    @installments = installments
    @installments_value = installments_value
  end

  def self.all(order_value)
    url = 'https://localhost:4000/api/v1/payment_options?' \
                                                    "order_value=#{order_value}"
    begin
      response = call_api(url)
    rescue Faraday::ConnectionFailed
      return []
    end
    json = catch_json(response)
    return [] if response.status == 500

    create_payments_options(json)
  end

  def self.call_api(url)
    Faraday.get(url)
  end

  def self.catch_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.create_payments_options(json)
    json.map do |j|
      PaymentOption.new(j[:name], j[:installments].to_i,
                        j[:installments_value].to_d)
    end
  end
end
