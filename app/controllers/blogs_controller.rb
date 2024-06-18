class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  def index
    @pagy, @blogs =
      if params[:my_posts_only].present? && current_user.present?
        pagy_cursor(Blog.where(author_id: current_user.id).includes(:author))
      else
        pagy_cursor(Blog.where(status: 'published').includes(:author))
      end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end

  # GET /blogs/1
  def show
    @comment = @blog.comments.build

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/new
  def new
    @blog = current_user.blogs.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /blogs
  def create
    @blog = current_user.blogs.build(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /blogs/1/edit
  def edit
    respond_to do |format|
      format.html # edit.html.erb
    end
  end

  # PATCH/PUT /blogs/1
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render json: @blog, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :status, :asset)
  end
end
