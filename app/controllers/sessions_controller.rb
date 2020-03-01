class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome,:destroy]
  def new
  end

  def create
    @user = User.find_by(username: params.require(:session)[:username])
    puts params.to_json
   if @user && @user.authenticate(params.require(:session)[:password])
      session[:user_id] = @user.id

      redirect_to '/welcome'
   else
      redirect_to '/login'
   end
  end

  def login
  end

  def welcome
  end
  
  def destroy
   session.delete(:user_id)
   current_user = nil
   redirect_to '/'
  end
end
