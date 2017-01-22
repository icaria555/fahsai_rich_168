class ProductStatement < ApplicationRecord
  belongs_to :product
  belongs_to :statement
  
  after_initialize :default_values
  
  def default_values
      self.total_price = 0 if self.total_price.nil?
      self.total_pv = 0 if self.total_pv.nil?
  end
  
  validates :quantity, :numericality => { only_integer: true, greater_than_or_equal_to: 0 }
  validates :total_price, :presence => true, :numericality => true
  validates :total_pv, :presence => true, :numericality => true
end
