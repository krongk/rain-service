# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site_page do
    user nil
    short_id "MyString"
    site nil
    title "MyString"
    content "MyText"
  end
end
