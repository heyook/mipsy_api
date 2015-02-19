class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session

  # protect_from_forgery \
  #   with: :null_session,
  #   if: -> (c) { c.request.format == 'application/vnd.heyook.v1' }

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :phone, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

end
