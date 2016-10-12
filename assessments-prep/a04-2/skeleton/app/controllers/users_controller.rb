class UsersController < ApplicationController
  def create
    user = User.new(required_params)

    if user.save
      login(user)
      redirect_to links_url
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  private
  def required_params
    params.require(:user).permit(:username, :password)
  end
end
