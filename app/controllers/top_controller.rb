class TopController < ApplicationController
  def index
    if current_user
      projects = current_user.projects
      @user_kanban_projects = projects.select{|project| Kanban.exists?(gitlab_project_id: project.id) }
      @no_kanban_projects   = projects.reject{|project| Kanban.exists?(gitlab_project_id: project.id) }

      user_project_ids = @user_kanban_projects.map(&:id)
      @other_kanbans = Kanban.where.not(gitlab_project_id: user_project_ids)
    end
  end
end
