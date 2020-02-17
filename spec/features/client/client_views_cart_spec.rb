require 'rails_helper'

feature 'Client views cart' do
  scenario 'successfully' do
    client = create(:client)
    create(:product_kit, name: 'Kit familiar', price: 20_000)
    # Teste do PaymentOptions feito em outra spec, necessário no cart controller
    allow(PaymentOption).to receive(:all).and_return([])
    login_as(client, scope: :client)

    visit root_path
    click_on 'Produtos'
    click_on 'Kit familiar'
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'

    expect(current_path).to have_content(cart_path)
    expect(page).to have_content('Kit familiar')
    expect(page).to have_content('R$ 20.000,00')
    expect(page).to have_content('Valor total: R$ 20.000,00')
    expect(page).to have_link('Finalizar Compra')
  end

  scenario 'and dont have any orders' do
    client = create(:client)
    # Teste do PaymentOptions feito em outra spec, necessário no cart controller
    allow(PaymentOption).to receive(:all).and_return(nil)
    login_as(client, scope: :client)

    visit root_path
    click_on 'Produtos'
    click_on 'Carrinho'

    expect(page).to have_content('Nenhum produto no seu carrinho')
  end

  scenario 'and has many kits' do
    client = create(:client)
    kit = create(:product_kit, name: 'Kit familiar', price: 20_000)
    create(:product_kit, name: 'Kit individual', price: 30_215)
    order = create(:order, client: client)
    create(:order_item, order: order, product_kit: kit)
    # Teste do PaymentOptions feito em outra spec, necessário no cart controller
    allow(PaymentOption).to receive(:all).and_return([])
    login_as(client, scope: :client)

    visit root_path
    click_on 'Produtos'
    click_on 'Kit individual'
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'

    expect(current_path).to have_content(cart_path)
    expect(page).to have_content('Kit familiar')
    expect(page).to have_content('R$ 20.000,00')
    expect(page).to have_content('Kit individual')
    expect(page).to have_content('R$ 30.215,00')
    expect(page).to have_content('Valor total: R$ 50.215,00')
    expect(page).to have_link('Finalizar Compra')
  end
end
