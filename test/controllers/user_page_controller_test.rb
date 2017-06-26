require 'test_helper'

class UserPageControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_page_create_url
    assert_response :success
  end

end
