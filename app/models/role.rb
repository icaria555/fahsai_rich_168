class Role < ApplicationRecord
  has_many :users
  has_many :discounts
  has_many :products, through: :discounts

  validates :name, :presence => true
	validates :level, :presence => true, :numericality => { only_integer: true, greater_than_or_equal_to: 0 }

	def self.admin
		Role.find_by_name("admin")
	end

	def self.employee
		Role.find_by_name("employee")
	end

	def self.wholesaler
		Role.find_by_name("wholesaler")
	end

	def self.mobile
		Role.find_by_name("mobile")
	end

	def self.member
		Role.find_by_name("member")
	end

end
