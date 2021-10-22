class ApplicationController < ActionController::Base
  before_action :configure_devise_message, if: :devise_controller?

  # before_action :gon_user

  private
  def configure_devise_message
    flash[:notice] = "You need to sign in or sign up before continuing."
  end

  def gon_user
    gon.user_id = current_user&.id
  end
end
