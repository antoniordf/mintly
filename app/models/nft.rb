class Nft < ApplicationRecord
  belongs_to :collection
  belongs_to :portfolio
end
