class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :gitlab_user_id
      t.string  :username
      t.string  :email
      t.string  :private_token

      t.timestamps
    end

    add_index :users, :gitlab_user_id, unique: true
  end
end
