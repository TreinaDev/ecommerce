require 'rails_helper'

feature 'Client see Payments Options' do
  scenario 'successfully' do
    client = create(:client)
    order = create(:order, client: client, status: :pending,
                           order_value: 2_000)
    json = File.read(Rails.root.join('spec/support/payment_options.json'))
    po = JSON.parse(json, symbolize_names: true)
    po1 = PaymentOption.new(po[0][:name], po[0][:value], po[0][:installments],
                            po[0][:one_shot], po[0][:total_value],
                            po[0][:installment_value])
    po2 = PaymentOption.new(po[1][:name], po[1][:value], po[1][:installments],
                            po[1][:one_shot], po[1][:total_value],
                            po[1][:installment_value])

    allow(PaymentOption).to receive(:all).with(order.order_value)
                                         .and_return([po1, po2])

    login_as(client, scope: :client)

    visit root_path
    click_on 'Meu Carrinho'

    expect(page).to have_content('Formas de Pagamento Disponiveis')
    expect(page).to have_content('Cartão de Crédito - 6 vezes de R$ 335,00 ou'\
                                  ' R$ 1.900,00 a vista')
    expect(page).to have_content('Boleto - 1 vez de R$ 1.800,00')
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
