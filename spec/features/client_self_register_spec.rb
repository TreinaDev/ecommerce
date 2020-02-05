require 'rails_helper'

feature 'Client self register' do
  scenario 'successfully' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'João'
    fill_in 'Endereço', with: 'Rua Alameda Santos, 1234'
    fill_in 'CEP', with: '12345-678'
    select 'Personal', from: 'Tipo de Cliente'
    fill_in 'Documento', with: '12345678900'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Criar Conta'

    expect(page).to have_content('A autenticação foi efetuada com sucesso.')
  end
end