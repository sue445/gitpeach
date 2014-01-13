# == Schema Information
#
# Table name: labels
#
#  id               :integer          not null, primary key
#  kanban_id        :integer
#  name             :string(255)
#  gitlab_label     :string(255)
#  disp_order       :integer
#  is_backlog_issue :boolean
#  is_close_issue   :boolean
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_labels_on_kanban_id_and_disp_order  (kanban_id,disp_order) UNIQUE
#

class Label < ActiveRecord::Base
  DEFAULTS = [
      {name: "Backlog"    , gitlab_label: nil          , is_backlog_issue: true , is_close_issue: false},
      {name: "Ready"      , gitlab_label: "ready"      , is_backlog_issue: false, is_close_issue: false},
      {name: "In Progress", gitlab_label: "in progress", is_backlog_issue: false, is_close_issue: false},
      {name: "Done"       , gitlab_label: nil          , is_backlog_issue: false, is_close_issue: true},
  ]

  scope :backlog, -> { where(is_backlog_issue: true , is_close_issue: false) }
  scope :done   , -> { where(is_backlog_issue: false, is_close_issue: true) }
  scope :other  , -> { where(is_backlog_issue: false, is_close_issue: false) }
end
