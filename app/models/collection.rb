class Collection < ApplicationRecord
  has_one :history
  has_many :nfts
end
