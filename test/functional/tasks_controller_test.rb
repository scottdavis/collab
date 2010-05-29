require File.join(File.dirname(__FILE__), '..', 'test_helper')

class TasksControllerTest < ActionController::TestCase
  
  context "User is logged in" do
    setup do
      @user = Factory(:user)
      sign_in_as(@user)
      @project = Factory(:project)
      5.times do
        Factory(:task, :project => @project)
      end
    end
    
    should "get index" do
      get :index, :project_id => @project
      assert assigns(:tasks)
      assert_equal 5, assigns(:tasks).size
      assert_response :success
    end
    
  end
  
end
