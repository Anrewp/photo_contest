class SessionsController < ApplicationController

  def create
    outcome = CreateUserSession.run(auth: request.env['omniauth.auth'].to_json)
    if outcome.valid?
      session[:user_id] = outcome.result.id
      flash[:success] = "Welcome, #{outcome.result.name}!"
      redirect_to user_path(outcome.result)
    else
      flash[:warning] = "There was an error while trying to authenticate you..."
      redirect_to root_path
    end
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end
end
