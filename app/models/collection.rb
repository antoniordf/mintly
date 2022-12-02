class Collection < ApplicationRecord
  has_many :histories
  has_many :nfts
  has_many :portfolio_collections
  validates :name, presence: true, uniqueness: true

  include PgSearch::Model
  pg_search_scope :search_by_name,
                  against: [:name],
                  using: {
                    tsearch: { prefix: true }
                  }
end
