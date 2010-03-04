path = File.join(RAILS_ROOT, 'factories')
require 'factory_girl'
require File.join(path, 'task_factory')
require File.join(path, 'project_factory')
class FactoryLoader 
  
  def self.up
    self.create_projects
  end
  
  def self.down
    [Task, Project].each {|klass| klass.delete_all}
  end
  
  
  def self.create_projects
    101.times do |i|
      p = Factory.create(:project)
      self.create_tasks(p)
    end
  end
  
  def self.create_tasks(project)
    5.times do |i|
      task = Factory.create(:task, :project => project)
      5.times do |n|
        t = Factory.create(:task, :project => project, :parent => task.id)
        2.times do |nn|
          Factory.create(:task, :project => project, :parent => t.id)
        end
      end
    end
  end
  
  
end