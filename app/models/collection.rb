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

  def cost
    cost = 0
    nfts.each do |nft|
      cost += nft.purchase_price * nft.purchase_quantity
    end
    return cost
  end

  def average_purchase_price
    cost / nfts_sum_quantity
  end

  def nfts_sum_quantity
    nfts.pluck(:purchase_quantity).reduce(:+)
  end

  def profit_and_loss(date)
    histories.find(date_time: date) - avg_nft_purchase_price
  end

end
