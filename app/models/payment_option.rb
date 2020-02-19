class PaymentOption
  attr_reader :name, :installments, :installment_value, :id, :one_shot,
              :total_value

  def initialize(id, one_shot, name, installments, installment_value,
                 total_value)
    @id = id
    @one_shot = one_shot
    @name = name
    @installments = installments
    @installment_value = installment_value
    @total_value = total_value
  end
  TOKEN = 'uPKJ332837AwMXoXrBJYjDCh'.freeze
  def self.all(order_value)
    url = "http://localhost:3000/api/v1/client/#{TOKEN}/" \
            "transaction_simulation?value=#{order_value}"
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
      new(j[:id], j[:one_shot], j[:name], j[:installments],
          j[:installment_value], j[:total_value])
    end
  end

  def post_api(order_id)
    url = "http://localhost:3000/api/v1/client/#{TOKEN}/order?"
    params = { order_value: total_value, order_id: order_id,
               payment_method_id: id, order_installments: installments,
               order_installments_value: installment_value }
    response = Faraday.post(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end
