class ProductStatement < ApplicationRecord
  belongs_to :product
  belongs_to :statement
end
