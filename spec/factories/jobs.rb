# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    title "MyString"
    location "MyString"
    description "MyText"
    contact "MyText"
    company "MyString"
    url "MyString"
  end
end
