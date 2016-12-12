require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  
  def setup
    @banmai = districts(:banmai)
    @thamuang = amphurs(:thamuang)
    @kanchanaburi = provinces(:kanchanaburi)
    @thamuang_zip = zipcodes(:thamuang_zip)
    @user = 	users(:rungroj)
    @order = @user.orders.create!(
      :purchaser_id => "name1",
      :saler_id => "description"
    )
    
  end

  # ==========================================================
  # test amount purchaser_id
  # ==========================================================
  
  test "purchaser_id should be exists" do
    @order.purchaser_id = nil
    assert_not @order.valid?
  end
  
  # ==========================================================
  # test amount saler_id
  # ==========================================================
  
  test "saler_id should be exists" do
    @order.saler_id = nil
    assert_not @order.valid?
  end
  
  # ==========================================================
  # test amount total_price
  # ==========================================================
  
  test "total_price should be 0" do
    assert @order.total_price == 0
  end
  
  test "total_price should be exists" do
    @order.total_price = nil
    assert_not @order.valid?
  end
  
  test "total_price should be integer" do
    @order.total_price = "text"
    assert_not @order.valid?
  end
  
  # ==========================================================
  # test amount total_pv
  # ==========================================================
  
  test "total_pv should be 0" do
    assert @order.total_pv == 0
  end
  
  test "total_pv should be exists" do
    @order.total_pv = nil
    assert_not @order.valid?
  end
  
  test "total_pv should be integer" do
    @order.total_pv = "text"
    assert_not @order.valid?
  end
  # ==========================================================
  # test amount saler_id
  # ==========================================================
  
  test "product should be exists" do
#    @product = products.find_by_id(1)
    @product = Product.new(
         :name => "fish",
         :description => "food",
         :price => 1000000,
         :pv => 0,
         :quantity => 2,
         )
    @orderproduct =  @order.order_products.create(
      product: @product,
      :quantity => 0)
    print @orderproduct.errors.full_messages
    assert @orderproduct.valid?
  end
  
end
