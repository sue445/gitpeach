class IssuesController < ApplicationController
  before_action :set_kanban

  unless Rails.env.test?
    before_action :authenticate_user
    before_action :set_user_kanban
    before_action :set_issue, only: [:update]

    rescue_from StandardError do |exception|
      Rails.logger.error exception.full_backtrace
      response = {
          status:    :error,
          exception: exception.class.to_s,
          message:   exception.message
      }
      render json: response, status: 500
    end
  end

  def update
    raise ArgumentError, "require to_label_id" unless params[:to_label_id]

    from_label_id = gitlab_current_issue_label_id
    @labels = @kanban.update_gitlab_issue_labels(gitlab_issue_labels, from_label_id, params[:to_label_id])
    @state  = @kanban.gitlab_issue_state(from_label_id, params[:to_label_id])

    update_gitlab_issue(@labels, @state)

    unless Rails.env.test?
      Pusher.trigger("kanban_#{@kanban.id}", :issue_update_event, {issues: @user_kanban.issues}, {socket_id: params[:socket_id]})
    end

    render json: updated_issue, status: 200
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

    def gitlab_current_issue_label_id
      @kanban.issue_label_id(@issue)
    end

    def update_gitlab_issue(labels, state_event)
      @user_kanban.update_issue(@issue.id, labels, state_event)
    end

    def updated_issue
      @user_kanban.issue(params[:id])
    end
end
