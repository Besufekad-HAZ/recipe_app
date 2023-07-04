class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  helper_method :sort_column, :sort_direction
  include ApplicationHelper

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
