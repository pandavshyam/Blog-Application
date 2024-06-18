# frozen_string_literal: true

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :blogs, class_name: 'Blog', inverse_of: :author, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  field :remember_created_at, type: Time
end
