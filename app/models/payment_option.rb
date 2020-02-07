require 'faraday'
require 'json'
class PaymentOption
  attr_reader :id, :name, :installments, :installment_value, :one_shot_value

  def initialize(id, name, installments, installment_value, one_shot_value)
    @id = id
    @name = name
    @installments = installments
    @installment_value = installment_value
    @one_shot_value = one_shot_value
  end


  def self.all()
    response = Faraday.get('http://localhost:3000/api/v1/payment_options')
    json = JSON.parse(response.body, symbolize_names: true)

    result = []
    json.each do |item|
      installments = item[:installments] || 1
      installment_value = item[:installment_value] || item[:one_shot_value]
      result << PaymentOption.new(item[:id], item[:name], installments,
                                  installment_value,
                                  item[:one_shot_value])
    end

    result
  end


end
