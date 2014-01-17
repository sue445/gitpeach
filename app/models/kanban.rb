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
    issues.group_by{|issue| issue_label_id(issue) }
  end

  # @return [Integer] label_id
  def issue_label_id(issue)
    if issue.state == "closed"
      self.labels.done.first.id
    else
      not_backlog_label = self.labels.other.where(gitlab_label: issue.labels).first
      not_backlog_label ? not_backlog_label.id : self.labels.backlog.first.id
    end
  end

  # @param gitlab_labels   [Array<String>]
  # @param from_label_id   [Integer]
  # @param to_label_id     [Integer]
  # @return [Array<String>]
  def update_gitlab_issue_labels(gitlab_labels, from_label_id, to_label_id)
    from_label = self.labels.find(from_label_id)
    to_label   = self.labels.find(to_label_id)

    updated_labels = []
    updated_labels << to_label.gitlab_label if from_label.is_backlog_issue? || from_label.is_close_issue?

    gitlab_labels.each do |gitlab_label|
      if gitlab_label == from_label.gitlab_label
        updated_labels << to_label.gitlab_label
      else
        updated_labels << gitlab_label
      end
    end

    updated_labels.compact
  end

  def gitlab_issue_state(from_label_id, to_label_id)
    from_label = self.labels.find(from_label_id)
    to_label   = self.labels.find(to_label_id)

    if from_label.opened? && to_label.closed?
      "close"
    elsif from_label.closed? && to_label.opened?
      "reopen"
    else
      # send "open" to "opened" issue (or send "close" to "closed" issue), 404 error at gitlab v6.4.3
      nil
    end
  end

  private
  def create_default_labels
    Label::DEFAULTS.each_with_index do |params, index|
      labels.create(params.merge(disp_order: index))
    end
  end
end
