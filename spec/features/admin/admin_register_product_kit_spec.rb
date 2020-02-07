require 'rails_helper'

feature 'Admin register product kit' do
  scenario 'successfully' do
    admin = create(:admin)
    solar_plate = create(:product, name: 'Placa solar A' :solar_plate)
    inversor = create(:product, name: 'Inversor pequeno', :inversor)
   
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Dashboard'
    click_on 'Kit de produtos'
    click_on 'Adicionar novo Kit de produtos'
    fill_in 'Nome', with: 'Kit residêncial'
    fill_in 'Descrição', with: 'Officia magna ea enim laborum.'
    fill_in 'Preço', with: 10000.00
    fill_in 'Peso', with: 340
    fill_in 'Largura', with: 2000
    fill_in 'Altura', with: 1000
    fill_in 'Espessura', with: 3000
    fill_in 'Garantia', with: 24
    attach_file('Foto do Kit', Rails.root.join('spec', 'support', 'kit.png'))
    click_on 'Enviar'

    expect(page).to have_content('Kit de produtos cadastrado(a) com sucesso')
    expect(page).to have_content('Nome: Kit residêncial')
    expect(page).to have_content('Descrição: Officia magna ea enim laborum.')
    expect(page).to have_content('Preço: R$ 10.000,00')
    expect(page).to have_content('Dimensão: 2000mm (L) x 1000mm (A) x ' \
                                 '3000mm (E)')
    expect(page).to have_content('Garantia: 24 meses')
    expect(page).to have_css("img[src*='kit.png']")
  end
end