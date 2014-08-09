# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    question "MyString"
    choices "MyText"
    creator_id 1
  end
end
