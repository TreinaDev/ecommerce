require 'rails_helper'

feature 'Client checkout his cart' do
  scenario 'sucessfully' do
    client = create(:client)
    create(:product_kit, name: 'Kit familiar', price: 2_000)
    login_as(client, scope: :client)
    json = File.read(Rails.root.join('spec/support/payment_options.json'))
    po = JSON.parse(json, symbolize_names: true)
    po1 = PaymentOption.new(po[0][:name], po[0][:value], po[0][:installments],
                            po[0][:one_shot], po[0][:total_value],
                            po[0][:installment_value])
    po2 = PaymentOption.new(po[1][:name], po[1][:value], po[1][:installments],
                            po[1][:one_shot], po[1][:total_value],
                            po[1][:installment_value])
    po3 = PaymentOption.new(po[2][:name], po[2][:value], po[2][:installments],
                            po[2][:one_shot], po[2][:total_value],
                            po[2][:installment_value])

    allow(PaymentOption).to receive(:all).with(2_000)
                                         .and_return([po1, po2, po3])

    visit root_path
    click_on 'Produtos'
    click_on 'Kit familiar'
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'
    click_on 'Finalizar Compra'

    expect(current_path).to eq checkout_path
    expect(client.orders.last.waiting_payment?).to eq true
    expect(page).to have_content('Kit familiar')
    expect(page).to have_content('Preço: R$ 2.000,00')
    expect(page).to have_content('Preço total: R$ 2.000,00')
    expect(page).to have_css('.credit_card')
    within('.credit_card') do
      expect(page).to have_content('Valor total: R$ 2.010,00')
      expect(page).to have_content('Em até: 6 x R$ 335,00')
      expect(page).to have_content('Número do cartão')
      expect(page).to have_content('Nome impresso no cartão')
      expect(page).to have_content('Validade')
      expect(page).to have_content('CVV')
      expect(page).to have_content('Parcelas')
      expect(page).to have_button('Pagar com cartão de crédito')
    end
    expect(page).to have_css('.debit')
    within('.debit') do
      expect(page).to have_content('Valor total: R$ 1.500,00')
      expect(page).to have_content('Nome do titular')
      expect(page).to have_content('Banco')
      expect(page).to have_content('Agência')
      expect(page).to have_content('Número da Conta')
      expect(page).to have_button('Pagar via débito em conta')
    end
    expect(page).to have_css('.boleto')
    within('.boleto') do
      expect(page).to have_content('Valor total: R$ 1.800,00')
      expect(page).to have_button('Gerar boleto')
    end
  end

  scenario 'and does not have any payment options available' do
    client = create(:client)
    create(:product_kit, name: 'Kit familiar', price: 20_000)
    login_as(client, scope: :client)

    allow(PaymentOption).to receive(:all).with(20_000)
                                         .and_return([])

    visit root_path
    click_on 'Produtos'
    click_on 'Kit familiar'
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'
    click_on 'Finalizar Compra'

    expect(page).to have_css('h3', text: 'Serviço de pagamentos fora do ar')
    expect(page).to have_content('Tente novamente em alguns instantes')
  end
end
