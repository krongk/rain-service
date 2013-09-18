# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_account do
    user nil
    name "MyString"
    value "MyString"
  end
end
