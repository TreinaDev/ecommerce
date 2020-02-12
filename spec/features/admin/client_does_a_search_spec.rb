require 'rails_helper'

feature 'Clients can search' do
  scenario 'Search for kit name' do
    customer = create(:client)
    create(:product_kit, name: 'Kit familiar')
    create(:product_kit, name: 'Kit industrial')

    login_as(customer, scope: :client)
    visit root_path
    fill_in 'Fazer busca', with: 'Kit familiar'
    click_on 'Buscar'

    expect(page).to have_content('Kit familiar')
    expect(page).not_to have_content('Kit industrial')
  end

  scenario 'search for solar plate name' do
    customer = create(:client)
    plate = create(:product, :solar_plate, name: 'Placa solar RX')
    kit = create(:product_kit, name: 'Kit domiciliar')
    kit2 = create(:product_kit, name: 'Kit industrial')
    create(:kit_item, product: plate, product_kit: kit)

    login_as(customer, scope: :client)
    visit root_path
    fill_in 'Fazer busca', with: 'Placa solar RX'
    click_on 'Buscar'

    expect(page).to have_css('h3', text: 'Resultado da busca Placa solar RX:')
    expect(page).to have_content('Kit domiciliar')
    expect(page).not_to have_content(kit2.name)
  end

  scenario 'search for inversor name' do
    customer = create(:client)
    inversor = create(:product, :inversor, name: 'Inversor medium')
    kit = create(:product_kit, name: 'Kit domiciliar')
    kit2 = create(:product_kit, name: 'Kit industrial')
    create(:kit_item, product: inversor, product_kit: kit2)

    login_as(customer, scope: :client)
    visit root_path
    fill_in 'Fazer busca', with: 'Inversor medium'
    click_on 'Buscar'

    expect(page).to have_css('h3', text: 'Resultado da busca Inversor medium:')
    expect(page).to have_content('Kit industrial')
    expect(page).not_to have_content(kit.name)
  end

  scenario 'not found' do

  end

  scenario 'guests can search too' do

  end

  scenario 'client can see kit infos by clicking on it' do 

  end
end
