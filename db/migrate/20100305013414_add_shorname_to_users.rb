class AddShornameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :short_name, :string
  end

  def self.down
    remove_column :users, :short_name
  end
end
