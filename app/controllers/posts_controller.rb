class PostsController < ApplicationController
    before_action :authorized, only: [:new,:create, :edit, :update, :destroy]
    before_action :find_post, only: [:show, :edit,:update,:destroy]
    before_action :identify_user, only: [:destroy,:edit]
     before_action :identify_user, only: [:destroy,:edit]
     def identify_user
        if current_user.id != Post.find(params[:id]).user_id
            @post = Post.find(params[:post_id])
        
            redirect_to @post
            flash[:alert] = "not id user"
        end
    end
    def index
        @posts = Post.all
        @users = User.select('id,username')
        puts @users.to_json
    end

    def new
        @post = Post.new
    end
    
    def create
        @post = Post.create(params[:post].permit(:title,:body).merge(:user_id => current_user.id))
    
        if @post.save
            redirect_to posts_path
        end
    end

    def show
        @originalList = @post.comments.select{ |comment| comment[:parent_id] == -1}
        @subList = @post.comments.select{ |comment| comment[:parent_id] != -1}
        @users = User.select('id,username')
    end
    
    def edit
    end

    def update
        if @post.update(params[:post].permit(:title,:body))
            redirect_to posts_path
        end
    end

    def destroy
        if @post.destroy
            redirect_to posts_path
        end
        

    end
    def find_post
        @post = Post.find(params[:id])
    end

  
end
