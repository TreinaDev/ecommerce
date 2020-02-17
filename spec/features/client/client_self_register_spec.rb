require 'rails_helper'

feature 'Client self register' do
  scenario 'successfully' do
    visit root_path
    click_on 'Inscreva-se'
    fill_in 'Nome', with: 'João'
    fill_in 'Endereço', with: 'Rua Alameda Santos, 1234'
    fill_in 'CEP', with: '12345-678'
    select 'Personal', from: 'Tipo de Cliente'
    fill_in 'Documento', with: '12345678900'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação de Senha', with: '123456'
    click_button 'Inscrever-se'

    expect(page).to have_content('Você realizou seu registro com sucesso.')
    expect(page).to have_button('Sair')
    expect(page).not_to have_button('Entrar')
  end

  scenario 'And fields are empty' do
    visit root_path
    click_on 'Entrar'
    click_on 'Inscrever-se'
    click_button 'Inscrever-se'

    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
    expect(page).to have_content('Name deve ser informado')
    expect(page).to have_content('Address deve ser informado')
    expect(page).to have_content('Zip code deve ser informado')
    expect(page).to have_content('Document deve ser informado')
  end

  scenario 'and receive a confirmation email on registrarion' do
    mailer_spy = class_spy(ClientMailer)
    stub_const('ClientMailer', mailer_spy)

    visit root_path
    click_on 'Entrar'
    click_on 'Inscrever-se'
    fill_in 'Nome', with: 'João'
    fill_in 'Endereço', with: 'Rua Alameda Santos, 1234'
    fill_in 'CEP', with: '12345-678'
    select 'Personal', from: 'Tipo de Cliente'
    fill_in 'Documento', with: '12345678900'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação de Senha', with: '123456'
    click_button 'Inscrever-se'

    client = Client.last

    expect(ClientMailer).to have_received(:welcome_email).with(client)
  end
end
