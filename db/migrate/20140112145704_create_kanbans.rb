class CreateKanbans < ActiveRecord::Migration
  def change
    create_table :kanbans do |t|
      t.integer :gitlab_project_id
      t.string  :name
      t.string  :slug

      t.timestamps
    end

    add_index :kanbans, :slug, unique: true
    add_index :kanbans, :name, unique: true
  end
end
