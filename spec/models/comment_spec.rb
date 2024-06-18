require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:blog) { FactoryBot.create(:blog) }

  it 'is valid with valid attributes' do
    comment = Comment.new(user_name: 'User Name', body: 'This is a comment', blog: blog)
    expect(comment).to be_valid
  end

  it 'is not valid without a user_name' do
    comment = Comment.new(user_name: nil, body: 'Test comment', blog: blog)
    expect(comment).not_to be_valid
  end

  it 'is not valid without a body' do
    comment = Comment.new(user_name: 'User Name', body: nil, blog: blog)
    expect(comment).not_to be_valid
  end

  it 'is not valid with a user_name longer than 255 characters' do
    comment = Comment.new(user_name: 'a' * 256, body: 'Test comment', blog: blog)
    expect(comment).not_to be_valid
  end

  it 'is not valid with a body longer than 2056 characters' do
    comment = Comment.new(user_name: 'User Name', body: 'a' * 2057, blog: blog)
    expect(comment).not_to be_valid
  end

  it 'can be associated with a blog' do
    comment = Comment.new(user_name: 'User Name', body: 'This is a comment', blog: blog)
    expect(comment.blog).to eq(blog)
  end
end
