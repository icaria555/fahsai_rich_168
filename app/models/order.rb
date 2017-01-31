class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products
  
  after_initialize :default_values
  
  def default_values
      self.total_price = 0 if self.total_price.nil?
      self.total_pv = 0 if self.total_pv.nil?
  end
  
  validates :purchaser_id, :presence => true
  validates :saler_id, :presence => true
  validates :total_price, :presence => true, :numericality => true
  validates :total_pv, :presence => true, :numericality => true
end
