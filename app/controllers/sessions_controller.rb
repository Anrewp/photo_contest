class SessionsController < ApplicationController

  def create
    outcome = CreateUserSession.run(auth: request.env['omniauth.auth'].to_json)
    if outcome.valid?
      session[:user_id] = outcome.result.id
      # token = JsonWebToken.encode(user_id: outcome.result.id)
      # cookies.signed[:jwt] = {value:  token, httponly: true}
      flash[:success] = "Welcome, #{outcome.result.name}!"
      redirect_to user_path(outcome.result)
      # time  = Time.now + 24.hours.to_i
      # render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
      #                username: outcome.result.name }, status: :ok
    else
      flash[:warning] = "There was an error while trying to authenticate you..."
      redirect_to root_path
    end
  end

  def destroy
    if current_user
      session.delete(:user_id)
      # cookies.delete(:jwt)
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end
end
