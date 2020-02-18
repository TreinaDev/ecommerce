# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: 'admin@test.com', password: '12345678')
Client.create!(email: 'client@test.com', password: '12345678', name: 'Teste',
               address: 'Rua Invisível', client_type: 'personal',
               zip_code: '00000-000', document: '123.123.212-32')

placa_solar = SolarPlate
              .create!(name: 'Placa Lunar', width: 1234, height: 123,
                       thickness: 1121, sku: '123-ABC-58', weight: 5.55,
                       purchase_price: 150.20, rated_power: 98, efficiency: 60)

inversor = Inversor
           .create!(name: 'Reversor', width: 1234, height: 123, thickness: 1121,
                    sku: '123-ABC-58', weight: 5.55, purchase_price: 150.20,
                    max_wattage: 123, max_voltage: 1200, max_current: 54)

20.times do |n|
  kit_produtos = ProductKit
                 .new(name: "Kit Residencial - #{n}", thickness: 4000,
                      description: 'Para pequenas residencias', weight: 60,
                      width: 5000, price: 10_000, height: 5000, warranty: 6)
  kit_produtos.picture.attach(io: File.open('spec/support/kit.png'),
                              filename: 'kit.png', content_type: 'image/png')

  kit_produtos.save!

  KitItem.create!(product_kit: kit_produtos, product: placa_solar, quantity: 20)
  KitItem.create!(product_kit: kit_produtos, product: inversor, quantity: 2)
end
