# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :label do
    kanban_id 1
    name "MyString"
    gitlab_label "MyString"
    is_backlog_issue false
    is_close_issue false
  end
end
