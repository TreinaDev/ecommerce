require 'rails_helper'

feature 'Client remove item from cart' do
  scenario 'successfully' do
    client = create(:client)
    kit = create(:product_kit, name: 'Kit familiar', price: 20_000)
    order = create(:order, client: client, order_value: 20_000)
    create(:order_item, order: order, product_kit: kit)
    # Teste do PaymentOptions feito em outra spec, necessário no cart controller
    allow(PaymentOption).to receive(:all).and_return([])
    login_as(client, scope: :client)

    visit root_path
    click_on 'Carrinho'
    click_on 'Remover'

    expect(current_path).to have_content(cart_path)
    expect(page).to have_content('Nenhum produto no seu carrinho')
    expect(page).not_to have_content('Kit familiar')
    expect(page).not_to have_content('R$ 20.000,00')
    expect(page).to have_content('Valor total: R$ 0,00')
    expect(page).not_to have_link('Finalizar Compra')
  end

  scenario 'and not have any kit' do
    client = create(:client)
    # Teste do PaymentOptions feito em outra spec, necessário no cart controller
    allow(PaymentOption).to receive(:all).and_return([])
    login_as(client, scope: :client)

    visit root_path
    click_on 'Carrinho'

    expect(page).not_to have_link('Remover')
    expect(page).to have_content('Nenhum produto no seu carrinho')
    expect(page).not_to have_content('Valor total')
    expect(page).not_to have_link('Finalizar Compra')
  end

  scenario 'and has more than one kit' do
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
    # remove 2o kit (kit individual)
    within('.cart tr:nth-child(2)') do
      click_on('Remover')
    end

    expect(current_path).to have_content(cart_path)
    expect(page).to have_content('Kit familiar')
    expect(page).to have_content('R$ 20.000,00')
    expect(page).not_to have_content('Kit individual')
    expect(page).not_to have_content('R$ 30.215,00')
    expect(page).to have_content('Valor total: R$ 20.000,00')
    expect(page).to have_link('Finalizar Compra')
  end
end
