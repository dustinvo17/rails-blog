class CommentsController < ApplicationController
    before_action :authorized, only: [:new, :create, :edit, :update, :destroy]
    before_action :identify_user, only: [:destroy]
    def identify_user
        if current_user.id != Comment.find(params[:id]).user_id
            @post = Post.find(params[:post_id])
        
            redirect_to @post
            flash[:alert] = "not id user"
        end
    end
    def new
        @comment = Comment.new
        render json:{status:'SUCCESS',data:@comment}
    end
    def destroy
        Comment.where(id: params[:id]).destroy_all
        Comment.where(parent_id: params[:id]).destroy_all
        @post = Post.find(params[:post_id])
        
        redirect_to @post
    end
    def create
            puts params[:comment_id].inspect
        if params.has_key?(:comment_id)
            @comment = Comment.create!(params.permit(:author,:body,:parent_id,:post_id).merge(:user_id => current_user.id))
            @post = Post.find(params[:post_id])
            if @comment.save
                redirect_to @post
            
            end

        else
            @post = Post.find(params[:post_id])
            @comment = @post.comments.create!(params.require(:comment).permit(:author,:body,:parent_id).merge(:user_id => current_user.id))
            if @comment.save
                redirect_to @post
            
            end
        end
       
    end
end
