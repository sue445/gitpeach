json.array!(@kanbans) do |kanban|
  json.extract! kanban, :id, :gitlab_project_id, :name, :slug
  json.url kanban_url(kanban, format: :json)
end
