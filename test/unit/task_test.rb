require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  
  test "Assignee Fails User Doesn't exist" do
    project = Factory.create(:project)
    task = Factory.create(:task, :project => project)
    
    task.assigned_id = 12000
    task.save
    
    assert !task.valid?
    assert_equal "Assignee doesn't exist", task.errors.first.last
  end
  
  test "Owner Fails User Doesn't exist" do
    project = Factory.create(:project)
    task = Factory.create(:task, :project => project)
    
    task.owner_id = 12000
    task.save
    
    assert !task.valid?
    assert_equal "Owner doesn't exist", task.errors.first.last
  end
  
  
end
