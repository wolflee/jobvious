# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :application do
    name "MyString"
    resume "MyString"
    user_id 1
    job_id 1
  end
end
