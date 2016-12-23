require 'test_helper'

class DiscountTest < ActiveSupport::TestCase
  test "default" do
    @role = roles(:wholesaler)
    @coffee = products(:one)
    @discount = @role.discounts.create(
      product: @coffee,
      :amount => 200
    )
    print @discount.errors.full_messages
    assert @discount.valid?
  end
end
