require 'rails_helper'

feature 'Visitor view product kits' do
  scenario 'and see all kits available' do
    create(:product_kit, name: 'Kit Básico')
    create(:product_kit, name: 'Kit Intermediário')
    create(:product_kit, name: 'Kit Avançado')

    visit root_path
    click_on 'Kits'

    expect(page).to have_css('h1', text: 'Kits de produtos:')
    expect(page).to have_link('Kit Básico')
    expect(page).to have_link('Kit Intermediário')
    expect(page).to have_link('Kit Avançado')
  end

  scenario 'and see a kit details' do
    product = create(:product, :solar_plate, name: 'Placa Solar Daora')
    other_product = create(:product, :inversor, name: 'Inversor reverso')
    kit = ProductKit.create!(name: 'Kit Básico',
                             description: 'Kit para residência pequena.',
                             price: 10_000.0, weight: 150, width: 2000,
                             height: 1500, thickness: 1000,
                             warranty: 3)
    create(:kit_item, product: product, product_kit: kit)
    create(:kit_item, product: other_product, product_kit: kit)

    visit root_path

    click_on 'Kits'
    click_on 'Kit Básico'

    expect(page).to have_css('h1', text: 'Kit Básico')
    expect(page).to have_content('1 x Placa Solar Daora')
    expect(page).to have_content('1 x Inversor reverso')
    expect(page).to have_content('Descrição: Kit para residência pequena.')
    expect(page).to have_content('Preço: R$ 10.000,00')
    expect(page).to have_content('Dimensão: 2000mm (L) x 1500mm (A) x ' \
                                 '1000mm (E)')
    expect(page).to have_content('Garantia: 3 meses')
  end

  scenario 'but there are no kits available' do
    visit root_path

    click_on 'Kits'

    expect(page).to have_css('h3', text: 'Não há kits disponíveis no momento!')
  end
end
