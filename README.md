# Portal Lunar

Portal Lunar é um e-commerce desenvolvido como projeto final do curso TreinaDev. No site vendemos kits que contém equipamentos utilizados na captação e distribuição de energia solar. 

Para nos ajudar com os pagamentos, nosso colegas desenvolveram um Gateway de pagamentos: https://github.com/TreinaDev/pagamento

Utilizamos o site do patrocinador `Portal Solar` como base no desenvolvimento do projeto: https://www.portalsolar.com.br/

## Configurações: 

* Ruby version: 2.6.5

* Rails version: 6.0.2

* System dependencies: macOS

## Como iniciar o projeto

* Seu computador deve ter preferencialmente macOS ou O.S Linux;

* Você pode utilizar o comdando `bin/setup` para configurar o que for necessário ou pode seguir os passos abaixo
{
  * Instale as dependências necessárias  definidas no    arquivo  `GemFile`, rodando o comando `bundle install`. 

  * SQLite3 é utilizado nesse projeto e para criar os bancos de dados basta rodar o comando `rails db:migrate`.
}

* Como estamos utilizando o `rails 6`, é preferivel utilizar o comando `yarn install --check-files` para a instalação de algumas dependências.

* Você já pode utilizar o comando `rails s` para ver a aplicação funcionando no endereço `localhost:3000` mas caso queira algum kit já cadastrado utilize o comando `rake db:seed`.

## Testes

  Nesse projeto foi utilizado `rspec` junto com `capybara`. Caso queira executar os testes, tendo seguido os passos acima, basta executar em seu terminal o comando `rspec` ou `bundle exec rspec`.

## Algumas Gems

* Para fazer a autenticação foi utilizada a gem `Devise`.

* Utilizamos a gem `Faraday` para acessar os end-points do gateway.

* *Para ajudar com a estilização do site utilizamos o framework `Bootstrap`.