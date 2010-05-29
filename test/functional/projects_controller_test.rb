require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ProjectsControllerTest < ActionController::TestCase
  
  
  
  context "User is logged in" do
    setup do
      @user = Factory(:user)
      sign_in_as(@user)
    end
  
    should "get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:projects)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create project" do
    
      assert_difference('Project.count') do
        post :create, :project => Factory.attributes_for(:project)
      end
      assert_redirected_to project_path(assigns(:project))
    end

    should "show project" do
      get :show, :id => Factory(:project).id
      assert_response :success
    end

    should "get edit" do
      get :edit, :id => Factory(:project).id
      assert_response :success
    end

    should "update project" do
      put :update, :id => Factory(:project).id, :project => Factory.attributes_for(:project)
      assert_redirected_to project_path(assigns(:project))
    end

    should "destroy project" do
      project = Factory(:project)
      assert_difference('Project.count', -1) do
        delete :destroy, :id => project.id
      end

      assert_redirected_to projects_path
    end
  end
end
