# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    user_id 1
    vote_id 1
    answer "MyString"
  end
end
