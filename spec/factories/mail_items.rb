# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mail_item do
    user nil
    email "MyString"
    source_name "MyString"
    name "MyString"
    city "MyString"
    area "MyString"
    description "MyString"
    is_processed "MyString"
  end
end
