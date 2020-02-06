require 'rails_helper'

feature 'Admin register carrier' do
  scenario 'successfully' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Cadastrar transportadora'
    fill_in 'Nome Fantasia', with: 'Zona Oeste courier'
    fill_in 'CNPJ', with: '82.676.748/0001-73'
    fill_in 'Razão Social', with: 'Carlos Silva Transportes LTDA'
    fill_in 'Logradouro', with: 'Av. Raimundo Pereira de Magalhaes'
    fill_in 'Número', with: '132'
    fill_in 'Complemento', with: '3º Andar'
    fill_in 'CEP', with: '02945-000'
    fill_in 'Bairro', with: 'Pirituba'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'

    click_on 'Confirmar registro'


    expect(page).to have_content('Transportadora cadastrada com sucesso')
    expect(page).to have_content('Transportadora: Zona Oeste courier')
    expect(page).to have_content('CNPJ: 82.676.748/0001-73')
    expect(page).to have_content('Razão Social: Carlos Silva Transportes LTDA')
    expect(page).to have_content('Logradouro: Av. Raimundo Pereira de Magalhaes')
    expect(page).to have_content('Número: 132')
    expect(page).to have_content('Complemento: 3º Andar')
    expect(page).to have_content('CEP: 02945-000')
    expect(page).to have_content('Bairro: Pirituba')
    expect(page).to have_content('Cidade: São Paulo')
    expect(page).to have_content('Estado: SP')
    expect(page).to have_link('Voltar')
  end

  scenario 'and must fill in all required fields' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Cadastrar transportadora'
    fill_in 'Nome Fantasia', with: 'Zona oeste courier'
    fill_in 'CNPJ', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'Logradouro', with: 'Av. Raimundo Pereira de Magalhaes'
    fill_in 'Número', with: '132'
    fill_in 'Complemento', with: '3º Andar'
    fill_in 'CEP', with: '02945-000'
    fill_in 'Bairro', with: 'Pirituba'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'

    click_on 'Confirmar registro'


    expect(page).not_to have_content('Transportadora cadastrada com sucesso')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Razão Social não pode ficar em branco')
  end
end
