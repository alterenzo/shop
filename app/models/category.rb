class Category < ApplicationRecord
  has_many :products
  has_and_belongs_to_many :vouchers
end
