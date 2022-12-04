class Collection < ApplicationRecord
  has_many :histories, dependent: :destroy
  has_many :nfts, dependent: :destroy
  has_many :portfolio_collections, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  has_many :portfolio_collections
  include PgSearch::Model
  pg_search_scope :search_by_name,
                  against: [:name],
                  using: {
                    tsearch: { prefix: true, any_word: true }
                  }
end
