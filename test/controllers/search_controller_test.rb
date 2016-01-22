require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "index status code 200" do
    get :index
    assert_equal 200, response.status
  end

end
