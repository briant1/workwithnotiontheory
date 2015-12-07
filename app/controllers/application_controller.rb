class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_sanitized_params, if: :devise_controller?

  def configure_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :name, :website_url, :github_url, :resume_url, :comments)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:project_heroku_url, :project_github_url)}
  end
end
