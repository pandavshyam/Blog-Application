require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'is valid with valid attributes' do
    blog = Blog.new(title: 'Blog 1', content: 'Test blog content', author_id: user.id)
    expect(blog).to be_valid
  end

  it 'is not valid without a title' do
    blog = Blog.new(title: nil, content: 'Test blog content', author_id: user.id)
    expect(blog).not_to be_valid
  end

  it 'is not valid without content' do
    blog = Blog.new(title: 'Blog 1', content: nil, author_id: user.id)
    expect(blog).not_to be_valid
  end

  it 'is not valid with a title longer than 255 characters' do
    blog = Blog.new(title: 'a' * 256, content: 'Test blog content', author_id: user.id)
    expect(blog).not_to be_valid
  end

  it 'is not valid without an author' do
    blog = Blog.new(title: 'Blog 1', content: 'Test blog content', author_id: nil)
    expect(blog).not_to be_valid
  end

  it 'is not valid with content longer than 2056 characters' do
    blog = Blog.new(title: 'Blog 1', content: 'a' * 2057, author_id: user.id)
    expect(blog).not_to be_valid
  end

  it 'is valid with status either draft or published' do
    blog1 = Blog.new(title: 'Blog 1', content: 'Test blog content', author_id: user.id, status: 'draft')
    blog2 = Blog.new(title: 'Blog 1', content: 'Test blog content', author_id: user.id, status: 'published')

    expect(blog1).to be_valid
    expect(blog2).to be_valid
  end

  it 'is not valid with a status other than draft or published' do
    blog = Blog.new(title: 'Blog 1', content: 'Test blog content', author_id: user.id, status: 'invalid_status')
    expect(blog).not_to be_valid
  end
end
