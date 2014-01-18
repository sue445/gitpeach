class TopController < ApplicationController
  def index
    projects = current_user.projects
    @kanban_projects    = projects.select{|project| Kanban.exists?(gitlab_project_id: project.id) }
    @no_kanban_projects = projects.reject{|project| Kanban.exists?(gitlab_project_id: project.id) }
  end
end
