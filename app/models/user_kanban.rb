class UserKanban
  attr_reader :project

  def initialize(user, kanban)
    @user    = user
    @kanban  = kanban
    @project = user.gitlab.project(@kanban.gitlab_project_id)
  end

  def issues
    # sort by newest
    @user.gitlab.issues(@kanban.gitlab_project_id, page: 1, per_page: 100).sort{ |a,b| b.updated_at <=> a.updated_at }
  end

  def issue(issue_id)
    @user.gitlab.issue(@kanban.gitlab_project_id, issue_id)
  end

  def issue_url(issue)
    issue_id = issue.iid || issue.id
    "#{@project.web_url}/issues/#{issue_id}"
  end

  def update_issue(issue_id, labels, state_event)
    options = {
        labels: labels.join(",")
    }
    options[:state_event] = state_event if state_event
    @user.gitlab.edit_issue(@project.id, issue_id, options)
  end

  def create_issue(title)
    @user.gitlab.create_issue(@project.id, title)
  end
end
