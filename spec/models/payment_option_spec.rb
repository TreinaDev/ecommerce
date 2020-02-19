require 'rails_helper'

describe PaymentOption do
  describe '.all' do
    it 'should get payment option through API' do
      payment_options = File.read(Rails.root.join(
                                    'spec/support/payment_options.json'
                                  ))
      response = double('response', status: 200, body: payment_options)
      token = '123abc'
      url = 'https://localhost:4000/' \
          "api/v1/client/#{token}/transaction_simulation?value=100"

      allow(Faraday).to receive(:get).with(url).and_return(response)

      result = PaymentOption.all(100)

      expect(result.length).to eq(3)
      expect(result[0].name).to eq('Cartão de Crédito')
      expect(result[0].installments).to eq(6)
      expect(result[0].installment_value).to eq('335.0')
      expect(result[1].name).to eq('Boleto')
      expect(result[1].installments).to eq(1)
      expect(result[1].one_shot).to eq('1800.0')
      expect(result[2].name).to eq('Debito')
      expect(result[2].installments).to eq(1)
      expect(result[2].one_shot).to eq('1500.0')
    end

    it 'should return empty array if API return error' do
      response = double('response', status: 500,
                                    body: '[{"error" : "API indisponivel"}]')
      token = '123abc'
      url = 'https://localhost:4000/' \
          "api/v1/client/#{token}/transaction_simulation?value=100"

      allow(Faraday).to receive(:get).with(url).and_return(response)

      result = PaymentOption.all(100)

      expect(result.length).to eq(0)
    end
  end
end
