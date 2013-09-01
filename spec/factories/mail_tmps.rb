# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mail_tmp do
    user nil
    title "MyString"
    content "MyText"
  end
end
