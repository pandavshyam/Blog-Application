require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:blog) { FactoryBot.create(:blog) }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Comment' do
        expect {
          post :create, params: { blog_id: blog.id, comment: { user_name: 'Test User', body: 'This is test comment' } }
        }.to change(Comment, :count).by(1)
      end

      it 'redirects to the blog show page' do
        post :create, params: { blog_id: blog.id, comment: { user_name: 'Test User', body: 'This is test comment' } }
        expect(response).to redirect_to(blog_path(blog))
      end
    end

    context 'with invalid params' do
      it 'does not create a new Comment' do
        expect {
          post :create, params: { blog_id: blog.id, comment: { user_name: '', body: '' } }
        }.not_to change(Comment, :count)
      end

      it 're-renders the blog show page' do
        post :create, params: { blog_id: blog.id, comment: { user_name: '', body: '' } }
        expect(response).to render_template('blogs/show')
      end
    end
  end
end
