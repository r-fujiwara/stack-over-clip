class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, unless: :need_oauth_authenticate

  before_action :doorkeeper_authorize!
  before_action :authenticate_user!

  def need_oauth_authenticate
    true
  end

  def set_parameter_from_accesstoken
    return unless doorkeeper_token.try(:resource_owner_id).present?
    user = User.find(doorkeeper_token.resource_owner_id)
    sign_in :user, user
    session[:current_user_id] = user.id
  end

  def authenticate_user!
    set_parameter_from_accesstoken
  end

  def auth

  end

end
