class OauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    handle_auth("Github")
  end

  def google_oauth2
    handle_auth("Google")
  end

  def handle_auth(kind)
    auth = request.env['omniauth.auth']
    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      session["devise.provider"] = auth.provider
      session["devise.uid"] = auth.uid
      redirect_to root_path, alert: "Something went wrong"
    end
  end
end