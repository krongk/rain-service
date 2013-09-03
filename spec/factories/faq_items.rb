# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :faq_item do
    faq_cate nil
    title "MyString"
    content "MyText"
  end
end
