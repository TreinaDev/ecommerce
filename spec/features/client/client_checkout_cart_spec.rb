require 'rails_helper'

feature 'Client checkout his cart' do
  scenario 'sucessfully' do
    client = create(:client)
    create(:product_kit, name: 'Kit familiar', price: 20_000)
    login_as(client, scope: :client)
    po1 = PaymentOption.new('Cartão de crédito', 12, 1672)
    po2 = PaymentOption.new('Débito em conta', 1, 19_700)
    po3 = PaymentOption.new('Boleto', 1, 19_800)

    allow(PaymentOption).to receive(:all).with(20_000)
                                         .and_return([po1, po2])

    visit root_path
    click_on 'Produtos'
    click_on 'Kit familiar'
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'
    click_on 'Finalizar Compra'

    expect(current_path).to eq checkout_path
    expect(client.orders.last.waiting_payment?).to eq true
    expect(page).to have_content('Kit familiar')
    expect(page).to have_content('Preço: R$ 20.000,00')
    expect(page).to have_content('Preço total: R$ 20.000,00')
    expect(page).to have_css('.credit_card')
    within('.credit_card') do
      expect(page).to have_content('Valor: TODO')
      expect(page).to have_content('Número do cartão')
      expect(page).to have_content('Nome impresso no cartão')
      expect(page).to have_content('Validade')
      expect(page).to have_content('CVV')
      expect(page).to have_content('Parcelas')
      expect(page).to have_button('Pagar com cartão de crédito')
    end
    expect(page).to have_css('.bank_transfer')
    within('.bank_transfer') do
      expect(page).to have_content('Valor: TODO')
      expect(page).to have_content('Nome')
      expect(page).to have_content('Banco')
      expect(page).to have_content('Agência')
      expect(page).to have_content('Conta')
      expect(page).to have_button('Pagar via débito em conta')
    end
    expect(page).to have_css('.boleto')
    within('.boleto') do
      expect(page).to have_content('Valor: TODO')
      expect(page).to have_button('Gerar boleto')
    end
  end
end