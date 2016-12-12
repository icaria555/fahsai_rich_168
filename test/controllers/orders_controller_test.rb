require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:rungroj)
    sign_in @user
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: {
        purchaser_id: 2,
        total_price: 200,
        total_pv: 10
      },
      list: {
        product1: {
          id: 1,
          quantity: 1,
          price: 1,
          pv: 1
        },
        product2: {
          id: 2,
          quantity: 1,
          price: 1,
          pv: 1
        }
      }
    }
    end
    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: {  
        :purchaser_id => 2,
        :total_price => 1000,
        :total_pv => 10
    } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
