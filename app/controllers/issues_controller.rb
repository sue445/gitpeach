class IssuesController < ApplicationController
  before_action :set_kanban

  unless Rails.env.test?
    before_action :authenticate_user
    before_action :set_user_kanban
    before_action :set_issue

    after_action :notify_event, only: [:create, :update]

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

  # POST /:kanban_id/issues
  def create
    created_issue = create_gitlab_issue(params[:title])
    render json: created_issue, status: 200
  end

  # GET /:kanban_id/issues/:id
  def show
    render partial: "shared/issue_panel", locals: {issue: @issue}
  end

  # PATCH/PUT /:kanban_id/issues/:id
  def update
    raise ArgumentError, "require to_label_id" unless params[:to_label_id]

    from_label_id = gitlab_current_issue_label_id
    @labels = @kanban.update_gitlab_issue_labels(gitlab_issue_labels, from_label_id, params[:to_label_id])
    @state  = @kanban.gitlab_issue_state(from_label_id, params[:to_label_id])

    update_gitlab_issue(@labels, @state)

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

    def create_gitlab_issue(title)
      @user_kanban.create_issue(title)
    end

    def notify_event
      label_groups = @kanban.label_groups(@user_kanban.issues)
      label_group_ids = label_groups.inject({}){|res, label_issues|
        label_id = label_issues[:label].id
        issues   = label_issues[:issues]
        res[label_id] = issues.map(&:id)
        res
      }

      Pusher.trigger("kanban_#{@kanban.id}", :issue_update_event, {label_group_ids: label_group_ids}, {socket_id: params[:socket_id]})
    end
end
