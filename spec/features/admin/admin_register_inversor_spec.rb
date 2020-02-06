require 'rails_helper'

feature 'Admin register inversor' do 
  scenario 'successfully' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Dashboard'
    click_on 'Produtos'
    click_on 'Adicionar novo Inversor'
    fill_in 'Nome', with: 'Inversor X'
    fill_in 'Largura', with: 375
    fill_in 'Altura', with: 375
    fill_in 'Espessura', with: 162
    fill_in 'Peso', with: 10.6
    fill_in 'Preço de compra', with: 5020.43
    fill_in 'SKU', with: 'INV-G-00172'
    fill_in 'Potência Máxima', with: 5000
    fill_in 'Tensão Máxima', with: 600
    fill_in 'Corrente Máxima', with: 15
    click_on 'Enviar'

    expect(page).to have_content('Inversor cadastrado(a) com sucesso')
    expect(page).to have_content('Nome: Inversor X')
    expect(page).to have_content('Dimensão: 375mm (L) x 375mm (A) x 162mm (E)')
    expect(page).to have_content('Peso: 10,60 kg')
    expect(page).to have_content('Preço de compra: R$ 5.020,43')
    expect(page).to have_content('SKU: INV-G-00172')
    expect(page).to have_content('Potência Máxima: 5000 W')
    expect(page).to have_content('Tensão Máxima: 600 V')
    expect(page).to have_content('Corrente Máxima: 15,0 A')
  end

  scenario 'but didnt fill in all fields' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit new_admin_inversor_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possivel cadastrar a placa solar')
    expect(page).to_not have_content('Placa solar cadastrada com sucesso')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Largura não pode ficar em branco')
    expect(page).to have_content('Altura não pode ficar em branco')
    expect(page).to have_content('Espessura não pode ficar em branco')
    expect(page).to have_content('Peso não pode ficar em branco')
    expect(page).to have_content('SKU não pode ficar em branco')
    expect(page).to have_content('Potência Máxima não pode ficar em branco')
    expect(page).to have_content('Tensão Máxima não pode ficar em branco')
    expect(page).to have_content('Corrente Máxima não pode ficar em branco')
  end

  scenario 'isnt logged in as admin' do
    client = create(:client)
    
    login_as(client, scope: :client)
    visit new_admin_inversor_path

    expect(current_path).to eq(new_admin_session_path)
  end

  scenario 'isnt logged in at all' do
    visit new_admin_inversor_path

    expect(current_path).to eq(new_admin_session_path)
  end
end