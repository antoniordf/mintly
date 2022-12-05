class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :portfolio_collections, dependent: :destroy
  has_many :collections, through: :portfolio_collections
  has_many :portfolio_nfts, dependent: :destroy
  has_many :nfts, through: :collections
end
