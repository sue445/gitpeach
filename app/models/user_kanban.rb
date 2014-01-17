class UserKanban
  attr_reader :project

  def initialize(user, kanban)
    @user    = user
    @kanban  = kanban
    @project = user.gitlab.project(@kanban.gitlab_project_id)
  end

  def issues
    @user.gitlab.issues(@kanban.gitlab_project_id, page: 1, per_page: 100)
  end

  def issue(issue_id)
    @user.gitlab.issue(@kanban.gitlab_project_id, issue_id)
  end

  def issue_url(issue)
    issue_id = issue.iid || issue.id
    "#{@project.web_url}/issues/#{issue_id}"
  end
end
