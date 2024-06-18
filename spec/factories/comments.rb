FactoryBot.define do
  factory :comment do
    user_name { 'User Name' }
    body { 'This is a comment' }
    association :blog, factory: :blog
  end
end
