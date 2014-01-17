class IssuesController < ApplicationController
  before_action :set_kanban

  unless Rails.env.test?
    before_action :authenticate_user
    before_action :set_user_kanban
    before_action :set_issue, only: [:update]

    rescue_from StandardError do |exception|
      response = {
          status:    :error,
          exception: exception.class.to_s,
          message:   exception.message
      }
      render json: response, status: 500
    end
  end

  def update
    @labels = @kanban.update_gitlab_issue_labels(gitlab_issue_labels, params[:from_label_id], params[:to_label_id])
    @state = @kanban.gitlab_issue_state(params[:from_label_id], params[:to_label_id])

    update_gitlab_issue(@labels, @state)

    response = {status: :success}
    render json: response, status: 200
  end

  private
    def set_kanban
      @kanban = Kanban.friendly.find(params[:kanban_id])
    end

    def set_user_kanban
      @user_kanban = UserKanban.new(current_user, @kanban) if current_user
    end

    def set_issue
      @issue = @user_kanban.issue(params[:id])
    end

    def gitlab_issue_labels
      @issue.labels
    end

    def update_gitlab_issue(labels, state)

    end
end
