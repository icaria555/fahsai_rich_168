class Statement < ApplicationRecord
  belongs_to :user
  has_many :statement_products
  has_many :products, through: :statement_products
  
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
