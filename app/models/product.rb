class Product < ApplicationRecord
  has_many :order_products
  has_many :product_statements
  has_many :stocks
  has_many :orders, through: :order_products
  has_many :discounts
  
  validates :name, :presence => true, :uniqueness => { case_sensitive: false }
  validates :price, :presence => true, :numericality => true
  validates :pv, :presence => true, :numericality => true
  validates :quantity, :presence => true, :numericality => { only_integer: true, greater_than_or_equal_to: 0 }
  validates :unit, :presence => true
end
