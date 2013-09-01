# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site_comment do
    site nil
    name "MyString"
    mobile_phone "MyString"
    email "MyString"
    content "MyText"
    is_processed false
  end
end
