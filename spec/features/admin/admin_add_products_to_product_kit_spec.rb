require 'rails_helper'

feature 'Admin add products to product kit' do
  scenario 'successfully add solar plate' do
    admin = create(:admin)
    create(:product, :solar_plate, name: 'Placa Solar Daora')
    create(:product, :solar_plate, name: 'Placa Solar Mais ou Menos')
    create(:product_kit, name: 'Kit Razer')

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Dashboard'
    click_on 'Kit de produtos'
    click_on 'Kit Razer'
    click_on 'Adicionar produto'
    select 'Placa Solar Daora', from: 'Produto (ID)'
    fill_in 'Quantidade', with: 20
    click_on 'Enviar'

    expect(page).to have_content('Produto adicionado(a) com sucesso')
    expect(page).to have_css('h1', text: 'Kit Razer')
    expect(page).to have_content('20 x Placa Solar Daora')
    expect(page).not_to have_content('Placa Solar Mais ou Menos')
  end

  scenario 'successfully add inversor' do
    admin = create(:admin)
    create(:product, :solar_plate, name: 'Placa Solar Daora')
    create(:product, :inversor, name: 'Inversor reverso')
    create(:product, :inversor, name: 'Inversor X')
    kit = create(:product_kit, name: 'Kit Logitech')

    login_as(admin, scope: :admin)
    visit new_admin_product_kit_kit_item_path(kit)
    select 'Inversor reverso', from: 'Produto (ID)'
    fill_in 'Quantidade', with: 1
    click_on 'Enviar'

    expect(page).to have_content('Produto adicionado(a) com sucesso')
    expect(page).to have_css('h1', text: 'Kit Logitech')
    expect(page).to have_content('1 x Inversor reverso')
    expect(page).not_to have_content('Placa Solar Daora')
    expect(page).not_to have_content('Inversor X')
  end

  scenario 'tried to add a product but didnt have any' do
    admin = create(:admin)
    kit = create(:product_kit, name: 'Kit Logitech')

    login_as(admin, scope: :admin)
    visit new_admin_product_kit_kit_item_path(kit)
    fill_in 'Quantidade', with: 1
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível cadastrar o(a) produto ' \
                                 'ao kit')
    expect(page).to have_content('Produto é obrigatório(a)')
  end

  scenario 'tried to add a product without quantity' do
    admin = create(:admin)
    create(:product, :solar_plate, name: 'Placa Solar Daora')
    kit = create(:product_kit, name: 'Kit Logitech')

    login_as(admin, scope: :admin)
    visit new_admin_product_kit_kit_item_path(kit)
    select 'Placa Solar Daora', from: 'Produto (ID)'
    fill_in 'Quantidade', with: 0
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível cadastrar o(a) produto ' \
                                 'ao kit')
    expect(page).to have_content('Quantidade deve ser maior que 0')
  end
end
