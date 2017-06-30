FactoryGirl.define do
  factory :page_bot do
    sequence(:access_token) { |n| n }
    sequence(:user_id) { |n| n }
    sequence(:page_id) { |n| n }
    name "Page name"
    picture_url 'google.com'
  end
end
