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

    expect(page).to have_css('h3', text: 'Resultado da busca Kit familiar:')
    expect(page).to have_link('Kit familiar')
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
    expect(page).to have_link('Kit domiciliar')
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
    expect(page).to have_link('Kit industrial')
    expect(page).not_to have_content(kit.name)
  end

  scenario 'not found' do
    customer = create(:client)

    login_as(customer, scope: :client)
    visit root_path
    fill_in 'Fazer busca', with: 'Kit A'
    click_on 'Buscar'

    expect(page).to have_content('Resultado da busca Kit A')
    expect(page).to have_content('Não foi encontrado nenhum resultado para ' \
                                 'sua pesquisa')
    expect(page).not_to have_link('Kit A')
  end

  scenario 'guests can search too' do
    create(:product_kit, name: 'Kit familiar')
    create(:product_kit, name: 'Kit industrial')

    visit root_path
    fill_in 'Fazer busca', with: 'Kit familiar'
    click_on 'Buscar'

    expect(page).to have_css('h3', text: 'Resultado da busca Kit familiar:')
    expect(page).to have_link('Kit familiar')
    expect(page).not_to have_content('Kit industrial')
  end

  scenario 'search is not case sensitives' do
    create(:product_kit, name: 'Kit familiar')

    visit root_path
    fill_in 'Fazer busca', with: 'kIt FamiLiar'
    click_on 'Buscar'

    expect(page).to have_css('h3', text: 'Resultado da busca kIt FamiLiar:')
    expect(page).to have_link('Kit familiar')
  end

  scenario 'client can see kit infos by clicking on it' do
    kit = create(:product_kit, name: 'Kit industrial', price: 50_000)
    plate = create(:product, :solar_plate, name: 'placa grande')
    inversor = create(:product, :inversor, name: 'inversor medium')
    create(:kit_item, product_kit: kit, product: plate)
    create(:kit_item, product_kit: kit, product: inversor)

    visit root_path
    fill_in 'Fazer busca', with: 'kit industrial'
    click_on 'Buscar'
    click_on 'Kit industrial'

    #expect(page).to have_content('Kit industrial')
    expect(page).to have_content(kit.description)
    expect(page).to have_content('R$ 50.000,00')
    expect(page).to have_content('placa grande')
    expect(page).to have_content('inversor medium')
  end
end
