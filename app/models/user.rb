# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  gitlab_user_id :integer
#  username       :string(255)
#  email          :string(255)
#  private_token  :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_users_on_gitlab_user_id  (gitlab_user_id) UNIQUE
#

class User < ActiveRecord::Base
  private
  def gitlab
    Gitlab.client(private_token: self.private_token)
  end
end
