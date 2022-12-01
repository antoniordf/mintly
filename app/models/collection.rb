class Collection < ApplicationRecord
  has_many :histories
  has_many :nfts
end
