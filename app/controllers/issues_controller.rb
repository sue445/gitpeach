class IssuesController < ApplicationController
  before_action :set_kanban

  unless Rails.env.test?
    before_action :authenticate_user
    before_action :set_user_kanban
  end

  def update
  end

  private
    def set_kanban
      @kanban = Kanban.friendly.find(params[:kanban_id])
    end

    def set_user_kanban
      @user_kanban = UserKanban.new(current_user, @kanban) if current_user
    end
end
