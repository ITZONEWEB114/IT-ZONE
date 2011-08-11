require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)#.merge({:customer_id => orders(:one).id})
		@order.customer_id=customers(:one).id
		@update= {
			:name => orders(:one).name,
			:address => orders(:one).address,
			:email => orders(:one).email,
			:pay_type => orders(:one).pay_type,
			:customer_id => customers(:one).id
		}
  end
	
  test "requires item in cart" do
    get :new
    assert_redirected_to store_path
    assert_equal flash[:notice], 'Your cart is empty'
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    cart = Cart.create
    session[:cart_id] = cart.id
    LineItem.create(:cart => cart, :product => products(:ruby))
    
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, :order => @update
    end
    assert_redirected_to store_path
  end

  test "should show order" do
    get :show, :id => @order.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @order.to_param, :customer_id => @order.customer_id
    assert_response :success
  end

  test "should update order" do
    put :update, :id => @order.to_param, :order => @update
    assert_redirected_to ship_orders_path( :previous_id => assigns(:order).id )
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, :id => @order.to_param
    end

    assert_redirected_to orders_path
  end
end
