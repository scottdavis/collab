class Wall < ActiveRecord::Base
  
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  belongs_to :project
  
  after_create :check_for_mentions, :check_for_hash_tags
  
  def check_for_mentions
    mentions = text.scan(/@([a-zA-Z_0-9])/).flatten
    User.find_all_by_short_name(mentions).each{ |user| user.send_post_notification(self) }
  end
  
  def check_for_hash_tags
    tags = text.scan(/#([a-zA-Z0-9_]+)/).flatten
    send_notice_to_members(project) if tags.include?('project')
  end
  
  def send_notice_to_members(project)
    project.users.each {|user| user.send_project_notification(project)}
  end
  
end
