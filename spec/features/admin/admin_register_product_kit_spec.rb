require 'rails_helper'

feature 'Admin register product kit' do
  scenario 'successfully' do
    admin = create(:admin)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Dashboard'
    click_on 'Kit de produtos'
    click_on 'Cadastrar Kit de produtos'
    fill_in 'Nome', with: 'Kit residêncial'
    fill_in 'Descrição', with: 'Officia magna ea enim laborum.'
    fill_in 'Preço', with: 10_000.00
    fill_in 'Peso', with: 340
    fill_in 'Largura', with: 2000
    fill_in 'Altura', with: 1000
    fill_in 'Espessura', with: 3000
    fill_in 'Garantia', with: 24
    attach_file('Imagem', Rails.root.join('spec/support/kit.png'))
    click_on 'Enviar'

    expect(page).to have_content('Kit de produtos cadastrado(a) com sucesso')
    expect(page).to have_css('h1', text: 'Kit residêncial')
    expect(page).to have_css("img[src*='kit.png']")
    expect(page).to have_content('Descrição: Officia magna ea enim laborum.')
    expect(page).to have_content('Preço: R$ 10.000,00')
    expect(page).to have_content('Dimensão: 2000mm (L) x 1000mm (A) x ' \
                                 '3000mm (E)')
    expect(page).to have_content('Garantia: 24 meses')
  end

  scenario 'filed only required fields' do
    admin = create(:admin)

    login_as(admin, scope: :admin)
    visit new_admin_product_kit_path
    fill_in 'Nome', with: 'Kit residêncial'
    fill_in 'Preço', with: 10_000.00
    fill_in 'Peso', with: 340
    fill_in 'Largura', with: 2000
    fill_in 'Altura', with: 1000
    fill_in 'Espessura', with: 3000
    fill_in 'Garantia', with: 3
    click_on 'Enviar'

    expect(page).to have_content('Kit de produtos cadastrado(a) com sucesso')
    expect(page).to have_css('h1', text: 'Kit residêncial')
    expect(page).not_to have_content('Descrição:')
    expect(page).to have_content('Preço: R$ 10.000,00')
    expect(page).to have_content('Dimensão: 2000mm (L) x 1000mm (A) x ' \
                                 '3000mm (E)')
    expect(page).to have_content('Garantia: 3 meses')
  end

  scenario 'mandatory fields must be filled' do
    admin = create(:admin)

    login_as(admin, scope: :admin)
    visit new_admin_product_kit_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível cadastrar o(a) Kit de ' \
                                 'produtos.')
    expect(page).to_not have_content('Kit de produtos cadastrado(a)' \
                                     ' com sucesso')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Largura não pode ficar em branco')
    expect(page).to have_content('Altura não pode ficar em branco')
    expect(page).to have_content('Espessura não pode ficar em branco')
    expect(page).to have_content('Peso não pode ficar em branco')
    expect(page).to have_content('Preço não pode ficar em branco')
    expect(page).to have_content('Garantia não pode ficar em branco')
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
