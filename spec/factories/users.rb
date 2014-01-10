# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    gitlab_user_id 1
    name "MyString"
    private_token "MyString"
  end
end
