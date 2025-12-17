class Order < ApplicationRecord
  validates :status, inclusion: { in: %w[pending approved rejected] }
  #enum status: { pending: 0, approved: 1, rejected: 2 }

  belongs_to :user
  validates :product_name, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :status, presence: true
  
  validates :product_name, uniqueness: { scope: :user_id }
 
  
 

  
end
