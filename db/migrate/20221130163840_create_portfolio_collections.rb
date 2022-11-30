class CreatePortfolioCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_collections do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.references :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
