class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def linkedin
    user = User.from_omniauth(request.env['omniauth.auth'], current_user)
    if user.persisted?
      flash[:notice] = "Successfully Linked in."
      sign_in_and_redirect(user)  # will have problem if enable :confirmable
    else
      session['devise.user_data'] = user.attributes
      redirect_to new_user_registration_url
    end
  end
end
