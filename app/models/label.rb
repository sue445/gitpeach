# == Schema Information
#
# Table name: labels
#
#  id               :integer          not null, primary key
#  kanban_id        :integer
#  name             :string(255)
#  gitlab_label     :string(255)
#  is_backlog_issue :boolean
#  is_close_issue   :boolean
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_labels_on_kanban_id_and_gitlab_label  (kanban_id,gitlab_label) UNIQUE
#

class Label < ActiveRecord::Base
end
