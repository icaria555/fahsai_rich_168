class Statement < ApplicationRecord
  has_many :product_statements
  has_many :products, through: :product_statements
  
  after_initialize :default_values
  
  def default_values
      self.total_price = 0 if self.total_price.nil?
      self.total_pv = 0 if self.total_pv.nil?
  end
  
  validates :giver_id, :presence => true
  validates :receiver_id, :presence => true
  validates :total_price, :presence => true, :numericality => true
  validates :total_pv, :presence => true, :numericality => true
end
