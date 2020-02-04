require 'rails_helper'

feature 'Client self register' do
  scenario 'successfully' do
    visit root_path
    click_on 'Log in'
    click_on 'Sign up'
    fill_in 'Nome', with: 'João'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Endereço', with: 'Rua Alameda Santos, 1234'
    fill_in 'CEP', with: '12345-678'
    select 'Pessoa Fisica', from: 'Tipo de Cliente'
    fill_in 'Documento', with: '12345678900'
    click_on 'Enviar'

    expect(page).to have_content('Cadastro realizado com sucesso!')
    expect(page).to have_content('Dados do Cliente:')
    expect(page).to have_content('Nome: João')
    expect(page).to have_content('Email: joao@email.com') 
    expect(page).to have_content('Endereço: Rua Alameda Santos, 1234') 
    expect(page).to have_content('CEP: 12345-678') 
    expect(page).to have_content('Tipo de Cliente: Pessoa Fisica') 
    expect(page).to have_content('Documento: 12345678900')
  end
end