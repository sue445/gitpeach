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

  private
  def create_default_labels
    Label::DEFAULTS.each_with_index do |params, index|
      labels.create(params.merge(disp_order: index))
    end
  end
end
