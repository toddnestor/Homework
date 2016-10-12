class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(required_params[:username], required_params[:password])

    if user
      login(user)
      redirect_to links_url
    else
      flash[:errors] = ["Invalid credentials"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  private
  def required_params
    params.require(:user).permit(:username, :password)
  end
end
