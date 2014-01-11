# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    gitlab_user_id { generate :random_int }
    username       { generate :random_str }
    private_token  { generate :random_str }

    factory :momozono_love do
      gitlab_user_id 1
      username       "momozono_love"
    end
  end
end
