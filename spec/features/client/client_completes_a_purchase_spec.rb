require 'rails_helper'

feature 'Client completes a purchase' do
  scenario 'successfully' do
    client = create(:client)
    create(:product_kit, name: 'Kit familiar', price: 20_000)
    login_as(client, scope: :client)
    # po1 = PaymentOption.new('Cartão de crédito', 12, 1672)
    # po2 = PaymentOption.new('Débito em conta', 1, 19_700)
    # po3 = PaymentOption.new('Boleto', 1, 19_800)

    # allow(PaymentOption).to receive(:all).with(20_000)
    #                                      .and_return([po1, po2, po3])

    # order_value=oneshot
    # order_installment=1
    # order_intallment_value=oneshot
    # order_id = boleto_id

    #teste passando usando a API, nao tem dados de mock ainda
    visit root_path
    click_on 'Produtos'
    click_on 'Kit familiar'
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'
    click_on 'Finalizar Compra'
    click_on 'Gerar boleto'

    expect(page).to have_content('Pedido realizado com sucesso.')
    expect(client.orders.last.in_progress?).to eq true
  end
end
