class ClientMailer < ApplicationMailer
  def welcome_email(client)
    @client = client
    mail(from: 'cadastro@portallunar.com.br',
         to: @client.email,
         subject: "Olá #{@client.name}, bem vindo ao Portal Lunar.")
  end
end
