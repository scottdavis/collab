class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.belongs_to :project
      t.text :description
      t.integer :parent

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
