# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone_call do
    user nil
    domain "MyString"
    from_ip "MyString"
    from_url "MyString"
    from_phone "MyString"
    is_processed false
    note "MyText"
  end
end
