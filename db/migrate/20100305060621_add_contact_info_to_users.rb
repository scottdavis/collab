class AddContactInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :phone, :string
    add_column :users, :mobile, :string
    add_column :users, :im, :string
  end

  def self.down
    remove_column :users, :im
    remove_column :users, :mobile
    remove_column :users, :phone
  end
end
