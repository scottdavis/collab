class CreateWalls < ActiveRecord::Migration
  def self.up
    create_table :walls do |t|
      t.belongs_to :project
      t.text :text
      t.belongs_to :user
      t.timestamps
    end
  end

  def self.down
    drop_table :walls
  end
end
