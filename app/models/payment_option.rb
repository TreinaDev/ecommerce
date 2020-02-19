class PaymentOption
  attr_reader :name, :value, :installments, :one_shot, :total_value,
              :installment_value
  # rubocop:disable Metrics/ParameterLists
  def initialize(name, value, installments, one_shot, total_value,
                 installment_value)
    @name = name
    @value = value
    @installments = installments
    @one_shot = one_shot
    @total_value = total_value
    @installment_value = installment_value
  end
  # rubocop:enable Metrics/ParameterLists

  def self.all(order_value)
    url = 'https://localhost:4000/' \
          "api/v1/client/123abc/transaction_simulation?value=#{order_value}"
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
      new(j[:name], j[:value], j[:installments].to_i, j[:one_shot],
          j[:total_value], j[:installment_value])
    end
  end
end
