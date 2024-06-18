FactoryBot.define do
  factory :blog do
    title { 'Test Blog' }
    content { 'Test Blog content' }
    status { 'draft' }
    association :author, factory: :user
  end
end
