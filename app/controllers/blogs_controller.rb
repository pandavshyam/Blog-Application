class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  def index
    @pagy, @blogs =
      if params[:my_posts_only].present? && current_user.present?
        pagy_cursor(Blog.desc(:updated_at).where(author_id: current_user.id))
      else
        pagy_cursor(Blog.where(status: 'published').desc(:updated_at))
      end
  end

  # GET /blogs/1
  def show; end

  # GET /blogs/new
  def new
    @blog = current_user.blogs.build
  end

  # POST /blogs
  def create
    @blog = current_user.blogs.build(blog_params)

    if @blog.save
      redirect_to @blog, notice: 'Blog was successfully created.'
    else
      render :new
    end
  end

  # GET /blogs/1/edit
  def edit; end

  # PATCH/PUT /blogs/1
  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: 'Blog was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog.destroy
    redirect_to blogs_url, notice: 'Blog was successfully destroyed.'
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :status)
  end
end
