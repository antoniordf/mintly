class Collection < ApplicationRecord
  belongs_to :portfolio
  has_one :history
  has_many :nfts
end
