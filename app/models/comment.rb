# frozen_string_literal: true

class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :blog

  field :user_name, type: String
  field :body, type: String

  validates :user_name, :body, presence: true
  validates :user_name, length: { maximum: 255 }
  validates :body, length: { maximum: 2056 }
end
