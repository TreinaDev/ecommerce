require 'rails_helper'

feature 'Admin register solar plate' do 
  scenario 'successfully' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Dashboard'
    click_on 'Produtos'
    click_on 'Adicionar nova Placa Solar'
    fill_in 'Nome', with: 'Placa solar A'
    fill_in 'Largura', with: 2024
    fill_in 'Altura', with: 1004
    fill_in 'Espessura', with: 35
    fill_in 'Peso', with: 24.90
    fill_in 'Preço de compra', with: 2000.0
    fill_in 'SKU', with: 'WEG-G-00172'
    fill_in 'Eficiência', with: 18.15
    fill_in 'Potência Nominal', with: 360
    click_on 'Enviar'

    expect(page).to have_content('Placa solar cadastrado(a) com sucesso')
    expect(page).to have_content('Nome: Placa solar A')
    expect(page).to have_content('Dimensão: 2024mm (L) x 1004mm (A) x 35mm (E)')
    expect(page).to have_content('Peso: 24,90 kg')
    expect(page).to have_content('Preço de compra: R$ 2.000,00')
    expect(page).to have_content('SKU: WEG-G-00172')
    expect(page).to have_content('Eficiência: 18.15%')
    expect(page).to have_content('Potência Nominal: 360Wp')
  end

  scenario 'but didnt fill in all fields' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit new_admin_solar_plate_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possivel cadastrar a placa solar')
    expect(page).to_not have_content('Placa solar cadastrado(a) com sucesso')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Largura não pode ficar em branco')
    expect(page).to have_content('Altura não pode ficar em branco')
    expect(page).to have_content('Espessura não pode ficar em branco')
    expect(page).to have_content('Peso não pode ficar em branco')
    expect(page).to have_content('SKU não pode ficar em branco')
    expect(page).to have_content('Eficiência não pode ficar em branco')
    expect(page).to have_content('Potência Nominal não pode ficar em branco')
  end

  scenario 'isnt logged in as admin' do
    client = create(:client)
    
    login_as(client, scope: :client)
    visit new_admin_solar_plate_path

    expect(current_path).to eq(new_admin_session_path)
  end

  scenario 'isnt logged in at all' do
    visit new_admin_solar_plate_path

    expect(current_path).to eq(new_admin_session_path)
  end
end