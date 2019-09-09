class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :user_id, :integer
    change_column :tasks, :is_completed, :boolean, default: false
  end
end
