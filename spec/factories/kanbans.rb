# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :kanban do
    gitlab_project_id 1
    name { generate :random_path }
  end
end
