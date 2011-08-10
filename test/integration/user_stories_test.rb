require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  fixtures :customers

  # Replace this with your real tests.
  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)
    
    get "/"
    assert_response :success
    assert_template "index"
    
    xml_http_request :post, 'line_items', :product_id => ruby_book.id
    assert_response :success
    
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size 
    assert ruby_book, cart.line_items[0].product
    
    get "/orders/new"
    assert_redirected_to customer_admin_login_url :locale=>I18n.locale
    
    #customer = customers(:one)
    #post customer_admin_login_url :locale=>I18n.locale,
     #                   :name => customer.name,
      #                  :password => '1'
    post_via_redirect customer_admin_login_url, :name => "liangzhenxiang", :password => "1"
    assert_response :success
    #assert_template "new" 
   
    #assert_redirected_to new_order_url
    
    post_via_redirect "/orders",
                      :order => { :name     => "Dave Thomas",
                                  :address  => "123 The Street",
                                  :email    => "dave@example.com",
                                  :pay_type => "Check" }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size
    
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
    
    assert_equal  "Dave Thomas", order.name
    assert_equal  "123 The Street", order.address
    assert_equal  "dave@example.com", order.email
    assert_equal  "Check", order.pay_type
    
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product
    
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'from@example.com', mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    
  end
end
