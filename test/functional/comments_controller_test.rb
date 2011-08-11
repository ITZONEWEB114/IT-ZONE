require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should get new" do
    get :new,:product_id=>@product.to_param
    assert_redirected_to show_product_url(:product_id=>@product)
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, :comment => @comment.attributes
    end
    assert_redirected_to store_url
  end

  test "should show comment" do
    get :show, :id => @comment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @comment.to_param
    assert_response :success
  end

  test "should update comment" do
    put :update, :id => @comment.to_param, :comment => @comment.attributes
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => @comment.to_param
    end

    assert_redirected_to comments_path
  end
end
