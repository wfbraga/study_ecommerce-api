class ApplicationController < ActionController::API
  before_action :configure_permitede_parameters, if: :devise_controller?

  protected

  def configure_permitede_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[reset_password_token password password_confirmation])
  end
end
