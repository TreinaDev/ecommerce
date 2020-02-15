class CustomRegistrationsController < Devise::RegistrationsController
  def create
    super
    ClientMailer.welcome_email(@client) if @client.persisted?
  end
end
