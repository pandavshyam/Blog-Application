class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :blog

  field :user_name, type: String
  field :body, type: String

  validates :user_name, :body, presence: true
end
