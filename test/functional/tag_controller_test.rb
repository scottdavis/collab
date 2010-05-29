require File.join(File.dirname(__FILE__), '..', 'test_helper')

class TagControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  context "update a tagged object" do
    setup do
      @user = Factory(:user)
      sign_in_as(@user)
    end
    should "set tag to foo and bar on a project" do
      project = Factory(:project)
      assert project.tags.blank?
      post :tag, {:type => 'project', :id => project.id, :value => 'foo, bar'}
      assert_response :success
      assert_equal @response.body, 'foo, bar'
      project.reload
      assert_equal project.tags.map(&:to_s), %w(foo bar)
    end
    should "not create tags on a non taggable model" do
      post :tag, {:type => 'user', :id => @user.id, :value => 'foo, bar'}
      assert_response :success
      assert @response.body.blank?
    end
  end
end
