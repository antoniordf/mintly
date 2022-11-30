class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :portfolio_collections
  has_many :collections, through: :portfolio_collections
  has_many :portfolio_nfts
  has_many :nfts, through: :portfolio_nfts
end
