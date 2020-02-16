require 'rails_helper'

feature 'Client visualize shipping price' do
  scenario 'successfully' do
    carrier = create(:carrier, name: 'Cheap trans')
    carrier_option = create(:carrier_option, carrier: carrier, min_vol: 20, max_vol: 40, price_kg: 20)
    carrier = create(:carrier, name: 'Expensive trans')
    carrier_option = create(:carrier_option, carrier: carrier, min_vol: 20, max_vol: 40, price_kg: 50)
    client = create(:client)
    product_kit = create(:product_kit, weight: 20, width: 2000, height: 3000,
                                       thickness: 5000)
    order = create(:order, client: client, status: :pending,
                           order_value: 20_000, product_kit: product_kit)
    po1 = PaymentOption.new('Cartão de Crédito', 12, 1672)
    po2 = PaymentOption.new('Boleto Bancário', 1, 19_800)

    allow(PaymentOption).to receive(:all).with(order.order_value)
                                         .and_return([po1, po2])

    login_as(client, scope: :client)

    visit root_path
    click_on 'Ver Carrinho'

    expect(page).to have_content('Formas de Pagamento Disponiveis')
    expect(page).to have_content('Cartão de Crédito - 12 vezes de R$ 1.672,00')
    expect(page).to have_content('Boleto Bancário - 1 vez de R$ 19.800,00')
    expect(page).to have_content('Frete: R$ 400,00, realizado pela transportadora: Cheap trans')

  end
end
