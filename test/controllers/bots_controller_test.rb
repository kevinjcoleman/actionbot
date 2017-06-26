require 'test_helper'

class BotsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get bots_show_url
    assert_response :success
  end

end
