class Project < ActiveRecord::Base
  has_many :tasks
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  validates_presence_of :name
  has_and_belongs_to_many :users
  validates_uniqueness_of :name
  
  named_scope :archived, :conditions => {:archived => true}
  named_scope :active, :conditions => {:archived => false}
  
end
