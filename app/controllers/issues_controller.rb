class IssuesController < ApplicationController
  before_action :set_kanban

  unless Rails.env.test?
    before_action :authenticate_user
    before_action :set_user_kanban
  end

  def update
  end

  def destroy
  end

  private
    def set_kanban
      @kanban = Kanban.friendly.find(params[:kanban_id])
    end
end
