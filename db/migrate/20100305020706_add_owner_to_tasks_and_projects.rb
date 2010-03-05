class AddOwnerToTasksAndProjects < ActiveRecord::Migration
  @tables = [:tasks, :projects]
  
  def self.up
    @tables.each do |table|
      add_column table, :owner_id, :integer
      add_index table, :owner_id
      add_foreign_key table, :users, :column => :owner_id
    end
    add_column :tasks, :assigned_id, :integer
    add_index :tasks, :assigned_id
  end

  def self.down
    @tables.each do |t|
      remove_column t, :owner_id
      remove_foreign_key t, :column => :owner_id
    end
    remove_column :tasks, :assigned_id
  end
end
