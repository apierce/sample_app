class SessionsController < ApplicationController

  def new

  end

  def create
    session = params[:session]
    user = User.find_by_email(session[:email].downcase)

    if user && user.authenticate(session[:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = "Invalid email/password combination!"
      render 'new'
    end

  end

  def destroy
  end


end
