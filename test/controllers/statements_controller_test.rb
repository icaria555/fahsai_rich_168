require 'test_helper'

class StatementsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:rungroj)
    sign_in @user
    @statement = statements(:one)
  end

  test "should get index" do
    get statements_url
    assert_response :success
  end

  test "should get new" do
    get new_statement_url
    assert_response :success
  end

  test "should create statement" do
    assert_difference('Statement.count') do
      post statements_url, params: { statement: {
        giver_id: 2,
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

    assert_redirected_to statement_url(Statement.last)
  end

  test "should show statement" do
    get statement_url(@statement)
    assert_response :success
  end

  test "should get edit" do
    get edit_statement_url(@statement)
    assert_response :success
  end

  test "should update statement" do
    patch statement_url(@statement), params: { statement: {  
        :giver_id => 2,
        :total_price => 1000,
        :total_pv => 10
    } }
    assert_redirected_to statement_url(@statement)
  end

  test "should destroy statement" do
    assert_difference('Statement.count', -1) do
      delete statement_url(@statement)
    end

    assert_redirected_to statements_url
  end
end
