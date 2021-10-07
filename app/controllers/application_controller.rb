class ApplicationController < ActionController::Base
  before_action :configure_devise_message, if: :devise_controller?

  private
  def configure_devise_message
    flash[:notice] = "You need to sign in or sign up before continuing."
  end
end
