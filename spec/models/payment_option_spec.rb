require 'rails_helper'

describe PaymentOption do
  describe '.all' do

    it 'should get payment_options through API' do

      url = 'http://localhost:3000/api/v1/payment_options'

      json = File.read(Rails.root.join('spec/support/payment_options_index.json'))

      mintirinha = double('resposta_do_faraday', status: 200, body: json)

      allow(Faraday).to receive(:get).with(url).and_return(mintirinha)

      result = PaymentOption.all

      expect(result.length).to eq 2
      expect(result[0].id).to eq 1
      expect(result[0].name).to eq 'Cartao de Credito'
      expect(result[0].one_shot_value).to eq '11000'
    end

    it 'should get payment_options withouth installments' do

      url = 'http://localhost:3000/api/v1/payment_options'

      json = File.read(Rails.root.join('spec/support/payment_options_without_installments.json'))

      mintirinha = double('resposta_do_faraday', status: 200, body: json)

      allow(Faraday).to receive(:get).with(url).and_return(mintirinha)

      result = PaymentOption.all

      expect(result.length).to eq 1
      expect(result[0].id).to eq 1
      expect(result[0].name).to eq 'Cartao de Credito'
      expect(result[0].one_shot_value).to eq '11000'
      expect(result[0].installments).to eq 1
      expect(result[0].installment_value).to eq '11000'
    end

 

    it 'should handle an API error' do
      url = 'http://localhost:3000/api/v1/payment_options'

      mintirinha = double('resposta_do_faraday', status: 500, body: '')

      allow(Faraday).to receive(:get).with(url).and_return(mintirinha)


      "[ { id: '12', name: 'debit', installments: '10', value: '1000' } ]"

      result = PaymentOption.all

      expect(result.lenght).to eq 0
    end
  end
end
