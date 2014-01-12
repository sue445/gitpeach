class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.integer :kanban_id
      t.string  :name
      t.string  :gitlab_label
      t.boolean :is_backlog_issue
      t.boolean :is_close_issue

      t.timestamps
    end

    add_index :labels, [:kanban_id, :gitlab_label], unique: true
  end
end
