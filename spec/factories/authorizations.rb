# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authorization do
    provider "MyString"
    uid "MyString"
    user_id 1
    username "MyString"
    token "MyString"
    secret "MyString"
  end
end
