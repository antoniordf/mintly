class RemovePortfolioFromCollections < ActiveRecord::Migration[7.0]
  def change
    remove_reference :collections, :portfolio, null: false, foreign_key: true
  end
end
