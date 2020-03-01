class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
      @user = User.create(params.require(:user).permit(:username , :password))
      session[:user_id] = @user.id
      puts @user.to_json
      if @user.save 
      redirect_to '/welcome'
      end
  end

  def posts
    @posts =  current_user.posts
    @users = User.all
    render 'posts/index'
  end
end
