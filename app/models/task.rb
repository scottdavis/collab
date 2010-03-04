class Task < ActiveRecord::Base
  belongs_to :project
  has_many :tasks, :foreign_key => :parent
  
  named_scope :parents, :conditions => {:parent => nil}
  
  validates_presence_of :name, :description, :project_id
  validates_associated :project
end
