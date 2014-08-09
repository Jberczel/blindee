# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invite do
    email "MyString"
    sender_id 1
    recpient_id 1
    vote_id 1
    token "MyString"
  end
end
