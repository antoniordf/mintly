class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :portfolio_collections, dependent: :destroy
  has_many :collections, through: :portfolio_collections
  has_many :portfolio_nfts, dependent: :destroy
  has_many :nfts

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
end
