require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  
  def setup
    @user = Factory(:user)
    sign_in_as(@user)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    
    assert_difference('Project.count') do
      post :create, :project => Factory.attributes_for(:project)
    end
    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, :id => Factory(:project).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => Factory(:project).id
    assert_response :success
  end

  test "should update project" do
    put :update, :id => Factory(:project).id, :project => Factory.attributes_for(:project)
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    project = Factory(:project)
    assert_difference('Project.count', -1) do
      delete :destroy, :id => project.id
    end

    assert_redirected_to projects_path
  end
end
