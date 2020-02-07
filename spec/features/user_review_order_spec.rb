require 'rails_helper'

feature 'User review order' do
  scenario 'and view all payment methods available' do
    order_value = 12000

    options =  [ PaymentOption.new(1, 'Cartao de Credito', 12, 1000, 11800),
                 PaymentOption.new(2, 'Cartao de Debito', 6, 2000, 11500) ]

    allow(PaymentOption).to receive(:all).and_return(options)

    visit root_path

    expect(page).to have_css('h3', text: 'Formas de Pagamento')
    expect(page).to have_content 'Cartão de Crédito'
    expect(page).to have_content '12 vezes de R$ 1.000,00'
    expect(page).to have_content 'Cartão de Débito'
    expect(page).to have_content '6 vezes de R$ 2.000,00'
  end

  scenario 'and view error if no payment method is available' do

    allow(PaymentOption).to receive(:all).and_return([])
  end
end
