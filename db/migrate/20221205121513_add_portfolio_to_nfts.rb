class AddPortfolioToNfts < ActiveRecord::Migration[7.0]
  def change
    add_reference :nfts, :portfolio, null: false, foreign_key: true
  end
end
