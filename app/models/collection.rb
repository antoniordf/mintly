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

  def value_on_date(date)
    total = 0
    nfts.each do |nft|
      next if nft.collection.histories.find_by(date_time: date).nil?

      if nft.purchase_date <= date
        total += nft.collection.histories.find_by!(date_time: date).price * nft.purchase_quantity
      else
        total += nft.collection.histories.find_by!(date_time: date).price * 0
      end
    end
    return total
  end

  def profit_and_loss(starting_date, end_date)
    value_on_date(end_date) - value_on_date(starting_date)
  end

  def profit_and_loss_percent(starting_date, end_date)
    (profit_and_loss(starting_date, end_date) / value_on_date(starting_date))
  end

  # def cost
  #   cost = 0
  #   nfts.each do |nft|
  #     cost += nft.purchase_price * nft.purchase_quantity
  #   end
  #   return cost
  # end

  # def average_purchase_price
  #   cost / nfts_sum_quantity
  # end

  # def nfts_sum_quantity
  #   nfts.pluck(:purchase_quantity).reduce(:+)
  # end

  # def profit_and_loss(date)
  #   histories.find_by(date_time: date) - average_purchase_price
  # end

  # def profit_and_loss_percent(date)
  #   (profit_and_loss(date) / cost)
  # end
end
