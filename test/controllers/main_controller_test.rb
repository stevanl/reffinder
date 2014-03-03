require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get site" do
    get :site
    assert_response :success
  end

  test "should get referrer" do
    get :referrer
    assert_response :success
  end

  test "should get category" do
    get :category
    assert_response :success
  end

  test "should get share" do
    get :share
    assert_response :success
  end

end
