# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone_item do
    user nil
    mobile_phone "MyString"
    source_name "MyString"
    name "MyString"
    city "MyString"
    area "MyString"
    description "MyString"
    is_processed "MyString"
  end
end
