class ClientMailer < ApplicationMailer
  def welcome_email(client_id)
    @client = Client.find(client_id)
    mail(from: 'cadastro@portallunar.com.br',
         to: @client.email,
         subject: "Olá #{@client.name}, bem vindo ao Portal Lunar.")
  end
end
