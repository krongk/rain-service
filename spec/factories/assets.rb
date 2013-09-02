# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset do
    user nil
    asset_type 1
    asset_name "MyString"
    asset_path "MyString"
    bucket "MyString"
    asset_key "MyString"
    note "MyString"
    return_hash "MyString"
  end
end
