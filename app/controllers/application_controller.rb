class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'devise', if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo])
  end
end
