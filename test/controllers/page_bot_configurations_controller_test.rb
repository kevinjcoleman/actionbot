require 'test_helper'

class PageBotConfigurationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get page_bot_configurations_show_url
    assert_response :success
  end

  test "should get update" do
    get page_bot_configurations_update_url
    assert_response :success
  end

end
