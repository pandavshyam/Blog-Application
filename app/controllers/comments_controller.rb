class CommentsController < ApplicationController
  def create
    @blog = Blog.where(id: params[:blog_id]).first
    @comment = @blog.comments.build(comment_params)

    if @comment.save
      redirect_to blog_path(@blog), notice: 'Comment was successfully created.'
    else
      render 'blogs/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_name, :body)
  end
end
