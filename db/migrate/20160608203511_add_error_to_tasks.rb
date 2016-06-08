class AddErrorToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :error, :string
  end
end
