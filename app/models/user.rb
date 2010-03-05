class User < ActiveRecord::Base
  include Clearance::User
  has_and_belongs_to_many :projects
  has_many :owned_projects, :class_name => "Project", :foreign_key => "owner_id"
  has_many :owned_tasks, :class_name => "Task", :foreign_key => "owner_id"
  has_many :assigned_tasks, :class_name => "Task", :foreign_key => "assigned_id"
  validates_uniqueness_of :short_name
  validates_presence_of :short_name
  validates_format_of :phone, :with => /^[0-9]{3}-[0-9]{3}-[0-9]{4}$/, :if => Proc.new {|user| !user.phone.blank?}
  validates_format_of :mobile, :with => /^[0-9]{3}-[0-9]{3}-[0-9]{4}$/, :if => Proc.new {|user| !user.mobile.blank?}
  
  def gravatar(size = 48)
    hash = Digest::MD5.hexdigest email
    "http://www.gravatar.com/avatar/#{hash}.jpg?s=#{size}"
  end
  
end
