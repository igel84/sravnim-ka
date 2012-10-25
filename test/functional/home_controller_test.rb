require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get wellcom" do
    get :wellcom
    assert_response :success
  end

end
