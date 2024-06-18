require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:blog) { FactoryBot.create(:blog, status: 'published', author: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all published blogs as blogs' do
      blog
      get :index
      expect(assigns(:blogs)).to include(blog)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    it "assigns only current user\'s blogs as @blogs when my_posts_only param is present" do
      other_user = FactoryBot.create(:user)
      FactoryBot.create(:blog, author: other_user)

      get :index, params: { my_posts_only: true }
      expect(assigns(:blogs)).to match_array(user.blogs)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested blog as @blog' do
      get :show, params: { id: blog.to_param }
      expect(assigns(:blog)).to eq(blog)
    end

    it 'renders the show template' do
      get :show, params: { id: blog.to_param }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new blog as @blog' do
      get :new
      expect(assigns(:blog)).to be_a_new(Blog)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Blog' do
        expect {
          post :create, params: { blog: { title: 'Test Blog', content: 'This is a test blog', status: 'published' } }
        }.to change(Blog, :count).by(1)
      end

      it 'redirects to the created blog' do
        post :create, params: { blog: { title: 'Test Blog', content: 'This is a test blog', status: 'published' } }
        expect(response).to redirect_to(Blog.last)
      end
    end

    context 'with invalid params' do
      it 're-renders the new template' do
        post :create, params: { blog: { title: '', content: '' } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested blog as @blog' do
      get :edit, params: { id: blog.to_param }
      expect(assigns(:blog)).to eq(blog)
    end

    it 'renders the edit template' do
      get :edit, params: { id: blog.to_param }
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the requested blog' do
        patch :update, params: { id: blog.to_param, blog: { title: 'Updated Title' } }
        blog.reload
        expect(blog.title).to eq('Updated Title')
      end

      it 'redirects to the blog' do
        patch :update, params: { id: blog.to_param, blog: { title: 'Test Blog', content: 'This is a test blog', status: 'published' } }
        expect(response).to redirect_to(blog)
      end
    end

    context 'with invalid params' do
      it 're-renders the edit template' do
        patch :update, params: { id: blog.to_param, blog: { title: '', content: '' } }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested blog' do
      blog_to_delete = FactoryBot.create(:blog, author: user)
      expect {
        delete :destroy, params: { id: blog_to_delete.to_param }
      }.to change(Blog, :count).by(-1)
    end

    it 'redirects to the blogs list' do
      delete :destroy, params: { id: blog.to_param }
      expect(response).to redirect_to(blogs_url)
    end
  end
end
