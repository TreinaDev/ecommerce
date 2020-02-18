class CustomRegistrationsController < Devise::RegistrationsController
  def create
    super
    ClientMailer.welcome_email(@client).deliver_now if @client.persisted?
  end
end
