class Discount < ApplicationRecord
  belongs_to :role
  belongs_to :product
end
