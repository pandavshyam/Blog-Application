# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_blog

  # POST /blogs/:blog_id/comments
  def create
    @comment = @blog.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @blog }
      else
        format.html { render 'blogs/show', status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_blog
    @blog = Blog.where(id: params[:blog_id]).first
    if @blog.nil?
      respond_to do |format|
        format.html { redirect_to blogs_url, notice: 'Invalid blog id' }
        format.json { render json: { message: 'Invalid blog id' } }
      end and return
    end
  end

  def comment_params
    params.require(:comment).permit(:user_name, :body)
  end
end
