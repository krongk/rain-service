# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mail_log do
    user nil
    mail_item nil
    mail_tmp nil
    status 1
    billing_count 1
  end
end
