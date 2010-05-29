class Project < ActiveRecord::Base
  acts_as_taggable
  acts_as_ferret :fields => %w(name), :store_class_name => true
  has_many :tasks
  has_many :wall_posts, :class_name => "Wall", :foreign_key => "project_id", :order => "created_at DESC"
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  validates_presence_of :name
  has_and_belongs_to_many :users
  validates_uniqueness_of :name
  
  named_scope :archived, :conditions => {:archived => true}
  named_scope :active, :conditions => {:archived => false}
  
end
