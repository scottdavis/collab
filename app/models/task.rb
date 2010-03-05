class Task < ActiveRecord::Base
  belongs_to :project
  has_many :tasks, :foreign_key => :parent
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  belongs_to :assignee, :class_name => "User", :foreign_key => 'assigned_id'
  #named scopes
  named_scope :parents, :conditions => {:parent => nil}
  #validations
  validates_presence_of :name, :description, :project_id
  validates_associated :project
  validate :assignee_validation, :owner_validation
  
  def assignee_validation
    unless assigned_id.blank?
      unless User.exists?(assigned_id)
        errors.add :assignee, "Assignee doesn't exist"
      end
    end
  end
  
  def owner_validation
    unless owner_id.blank?
      unless User.exists?(owner_id)
        errors.add :owner, "Owner doesn't exist"
      end
    end
  end
  
  
  
end
