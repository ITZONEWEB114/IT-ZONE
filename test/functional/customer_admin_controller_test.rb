require 'test_helper'

class CustomerAdminControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get confirm" do
    get :confirm
    assert_response :success
  end

end
