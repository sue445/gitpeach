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
#  index_kanbans_on_name  (name) UNIQUE
#  index_kanbans_on_slug  (slug) UNIQUE
#

class Kanban < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :labels, -> { order(:disp_order) }, dependent: :destroy

  after_create :create_default_labels

  def normalize_friendly_id(text)
    text
  end

  # @return [Hash] key: label_id, value: issues
  def issues_group_by_label(issues)
    backlog_id = self.labels.backlog.first.id
    done_id    = self.labels.done.first.id
    issues ||= []
    issues.group_by{|issue|
      next done_id   if issue.state == "closed"

      not_backlog_label = self.labels.other.where(gitlab_label: issue.labels).first
      not_backlog_label ? not_backlog_label.id : backlog_id
    }
  end

  private
  def create_default_labels
    Label::DEFAULTS.each_with_index do |params, index|
      labels.create(params.merge(disp_order: index))
    end
  end
end
