require 'rails_helper'

feature 'Client visualize shipping price' do
  xscenario 'Successful' do
    client = create(:client)
    login_as(client, scope: :client)
    kit = Product_kit.create!(weight: 5, height: 2, depth: 3, width: 10)

    login_as(client, scope: :client)


  end
end