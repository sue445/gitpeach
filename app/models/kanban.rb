# == Schema Information
#
# Table name: kanbans
#
#  id                :integer          not null, primary key
#  gitlab_project_id :integer
#  name              :string(255)
#  slug              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_kanbans_on_slug  (slug) UNIQUE
#

class Kanban < ActiveRecord::Base
end
