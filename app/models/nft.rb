class Nft < ApplicationRecord
  before_create do
    self.purchase_quantity = 1
  end
  belongs_to :collection
  belongs_to :portfolio
end
