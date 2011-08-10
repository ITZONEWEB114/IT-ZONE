require 'test_helper'

class CustomerAdminControllerTest < ActionController::TestCase  
  test "should get login" do
    get :login
    assert_response :success
  end
  
  test "should login" do
    liangzhenxiang = customers(:one)
    post:judge, :name => liangzhenxiang.name, :password => '1'
    assert_redirected_to session[:page]
    assert_equal liangzhenxiang.id, session[:customer_id]
  end

  test "should get confirm" do
    get :confirm
    assert_response :success
  end

end
