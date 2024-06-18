class CommentsController < ApplicationController
  def create
    @blog = Blog.where(id: params[:blog_id]).first
    @comment = @blog.comments.create(comment_params)
    redirect_to blog_path(@blog)
  end

  private

  def comment_params
    params.require(:comment).permit(:user_name, :body)
  end
end
