# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sms_log do
    user nil
    phone_item nil
    sms_tmp nil
    status 1
    billing_count 1
  end
end
