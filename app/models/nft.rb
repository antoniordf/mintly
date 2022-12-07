class Nft < ApplicationRecord
  before_create do
    self.purchase_quantity = 1
  end
  belongs_to :collection
  belongs_to :portfolio

  validates :purchase_date, :purchase_price, presence: true
end
