class User < ActiveRecord::Base
  acts_as_ferret :fields => %w(short_name email), :store_class_name => true
  include Clearance::User
  has_and_belongs_to_many :projects
  has_many :owned_projects, :class_name => "Project", :foreign_key => "owner_id"
  has_many :owned_tasks, :class_name => "Task", :foreign_key => "owner_id"
  has_many :assigned_tasks, :class_name => "Task", :foreign_key => "assigned_id"
  validates_uniqueness_of :short_name
  validates_presence_of :email, :password, :short_name
  validates_format_of :phone, :with => /^[0-9]{3}-[0-9]{3}-[0-9]{4}$/, :if => Proc.new {|user| !user.phone.blank?}
  validates_format_of :mobile, :with => /^[0-9]{3}-[0-9]{3}-[0-9]{4}$/, :if => Proc.new {|user| !user.mobile.blank?}
  
  before_validation :set_short_name
  
  def set_short_name
    if short_name.blank?
      short_name = email.split('@')[0]
    end
  end
  
  def gravatar(size = 48)
    hash = Digest::MD5.hexdigest email
    "http://www.gravatar.com/avatar/#{hash}.jpg?s=#{size}"
  end
  
  def send_post_notification(post)
    project_id = post.project_id
  end
  
  def send_project_notification(project)
    
  end
  
end
