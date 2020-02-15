require 'rails_helper'
RSpec.describe ClientMailer do
  describe '#welcome_email' do
    it 'should send a welcome email to client email on registration' do
      client = create(:client, email: 'cliente@teste.com')
      email = ClientMailer.welcome_email(client.id)

      expect(email.to).to include(client.email)
    end

    it 'should send from correct email' do
      client = create(:client, email: 'cliente@teste.com')
      email = ClientMailer.welcome_email(client.id)

      expect(email.from).to include('cadastro@portallunar.com.br')
    end

    it 'should have the correct subject' do
      client = create(:client, name: 'José Santos', email: 'cliente@teste.com')
      email = ClientMailer.welcome_email(client.id)

      expect(email.subject).to eq('Olá José Santos, bem vindo ao Portal Lunar.')
    end

    it 'should have the correct message' do
      client = create(:client, name: 'José Santos', email: 'cliente@teste.com')
      email = ClientMailer.welcome_email(client.id)

      expect(email.body).to have_css('h1', text: 'Caro(a) José Santos, '\
                                                  'bem vindo ao Portal Solar!')
      expect(email.body).to have_css('p', text: 'Seu cadastro foi efetivado '\
                                                'com sucesso, agora você '\
                                                'pode aproveitar os melhores ' \
                                                'preços e promoções em paineis'\
                                                ' solares.')
      expect(email.body).to have_css('p', text: 'Seja bem vindo e tenha '\
                                                'um ótimo dia!')
    end
  end
end
