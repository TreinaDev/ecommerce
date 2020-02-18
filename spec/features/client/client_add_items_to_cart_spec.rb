require 'rails_helper'

feature 'Client add Product Kit to cart' do
  scenario 'successfully' do
    client = create(:client)
    create(:product_kit, name: 'Kit individual')
    kit = create(:product_kit, name: 'Kit familiar')
    order = Order.count
    login_as(client, scope: :client)

    visit root_path
    click_on 'Produtos'
    click_on 'Kit familiar'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_content('Adicionado ao carrinho')
    expect(current_url).to eq(url_for(kit))
    expect(Order.count).to eq(order + 1)
  end

  scenario 'but wasnt logged in' do
    kit = create(:product_kit, name: 'Kit individual')
    order = Order.count

    visit product_kit_path(kit)
    click_on 'Adicionar ao carrinho'

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
    expect(current_path).to eq(new_client_session_path)
    expect(Order.count).to eq(order)
  end

  scenario 'and already have an order' do
    client = create(:client)
    kit = create(:product_kit, name: 'Kit familiar')
    order = create(:order, client: client)
    create(:order_item, product_kit: kit, order: order)
    added_kit = create(:product_kit, name: 'Kit individual')
    items_count = order.order_items.count
    order_count = Order.all.count
    login_as(client, scope: :client)

    visit product_kit_path(added_kit)
    click_on 'Adicionar ao carrinho'

    expect(page).to have_content('Adicionado ao carrinho')
    expect(current_url).to eq(url_for(added_kit))
    expect(order.order_items.count).to eq(items_count + 1)
    expect(Order.all.count).to eq(order_count)
  end
end
