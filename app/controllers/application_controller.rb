class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resources)
    stored_location_for(resource) || client_path(:id)
  end
end
