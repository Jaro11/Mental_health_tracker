require "test_helper"

class TipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tips_index_url
    assert_response :success
  end

  test "should get show" do
    get tips_show_url
    assert_response :success
  end
end
