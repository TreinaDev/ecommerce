require 'rails_helper'

feature 'Client see Payments Options' do
  scenario 'successfully' do
    client = create(:client)
    order = create(:order, client: client, status: :pending,
                           order_value: 20_000)
    po1 = PaymentOption.new('Cartão de Crédito', 12, 1672)
    po2 = PaymentOption.new('Boleto Bancário', 1, 19_800)

    allow(PaymentOption).to receive(:all).with(order.order_value)
                                         .and_return([po1, po2])

    login_as(client, scope: :client)

    visit root_path
    click_on 'Meu Carrinho'

    expect(page).to have_content('Formas de Pagamento Disponiveis')
    expect(page).to have_content('Cartão de Crédito - 12 vezes de R$ 1.672,00')
    expect(page).to have_content('Boleto Bancário - 1 vez de R$ 19.800,00')
  end

  scenario 'and theres no payment option available' do
    client = create(:client)
    order = create(:order, client: client, status: :pending,
                           order_value: 20_000)

    allow(PaymentOption).to receive(:all).with(order.order_value).and_return([])

    login_as(client, scope: :client)

    visit root_path
    click_on 'Meu Carrinho'

    expect(page).to have_content('Nenhuma Forma de Pagamento Disponivel no ' \
                                 'momento')
    expect(page).to have_content('Tente novamente mais tarde')
  end
end
