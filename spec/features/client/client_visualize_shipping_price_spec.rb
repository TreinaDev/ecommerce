require 'rails_helper'

feature 'Client visualize shipping price' do
  scenario 'successfully' do
    carrier = create(:carrier, name: 'Cheap trans')
    carrier_option = create(:carrier_option, carrier: carrier, min_vol: 20, max_vol: 40, price_kg: 20)
    carrier2 = create(:carrier, name: 'Expensive trans')
    carrier_option2 = create(:carrier_option, carrier: carrier2, min_vol: 20, max_vol: 40, price_kg: 50)
    client = create(:client)
    kit = create(:product_kit, name: 'Kit familiar', price: 20_000,  weight: 20, width: 2000, height: 3000,
                               thickness: 5000)
    order = create(:order, client: client, order_value: 20_000)
    create(:order_item, order: order, product_kit: kit)
    allow(PaymentOption).to receive(:all).and_return([])
    login_as(client, scope: :client)

    visit root_path
    click_on 'Carrinho'

    expect(current_path).to have_content(cart_path)
    expect(page).to have_content('Kit familiar')
    expect(page).to have_content('R$ 20.000,00')
    expect(page).to have_link('Finalizar Compra')
    expect(page).to have_content('Frete: R$ 400,00')
    expect(page).to have_content('realizado pela transportadora: Cheap trans')
  end

  scenario 'without carriers avaiable for this item' do
    carrier = create(:carrier, name: 'Cheap trans')
    carrier_option = create(:carrier_option, carrier: carrier, min_vol: 20, max_vol: 40, price_kg: 20)
    carrier2 = create(:carrier, name: 'Expensive trans')
    carrier_option2 = create(:carrier_option, carrier: carrier2, min_vol: 20, max_vol: 40, price_kg: 50)
    client = create(:client)
    kit = create(:product_kit, name: 'Kit familiar', price: 20_000,  weight: 20, width: 10000, height: 3000,
                               thickness: 5000)
    order = create(:order, client: client, order_value: 20_000)
    create(:order_item, order: order, product_kit: kit)
    allow(PaymentOption).to receive(:all).and_return([])
    login_as(client, scope: :client)

    visit root_path
    click_on 'Carrinho'

    expect(current_path).to have_content(cart_path)
    expect(page).to have_content('Kit familiar')
    expect(page).to have_content('R$ 20.000,00')
    expect(page).to have_link('Finalizar Compra')
    expect(page).to have_content('Nenhunha transportadora disponível para este produto')
  end
end
