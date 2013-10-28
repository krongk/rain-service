# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone_call_log do
    user nil
    phone_call nil
    status "MyString"
    billing_count "MyString"
  end
end
