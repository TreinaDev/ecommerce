require 'rails_helper'

describe PaymentOption do
  describe '.all' do
    it 'should get payment option through API' do
      payment_options = File.read(Rails.root.join(
                                    'spec/support/payment_options.json'
                                  ))
      response = double('response', status: 200, body: payment_options)
      url = 'https://localhost:4000/api/v1/payment_options?order_value=100'

      allow(Faraday).to receive(:get).with(url).and_return(response)

      result = PaymentOption.all(100)

      expect(result.length).to eq(2)
      expect(result[0].name).to eq('Cartão de Crédito')
      expect(result[0].installments).to eq(12)
      expect(result[0].installment_value).to eq(10)
      expect(result[1].name).to eq('Boleto Bancário')
      expect(result[1].installments).to eq(1)
      expect(result[1].installment_value).to eq(90)
    end

    it 'should return empty array if API return error' do
      response = double('response', status: 500,
                                    body: '[{"error" : "API indisponivel"}]')
      url = 'https://localhost:4000/api/v1/payment_options?order_value=100'

      allow(Faraday).to receive(:get).with(url).and_return(response)

      result = PaymentOption.all(100)

      expect(result.length).to eq(0)
    end
  end
end
