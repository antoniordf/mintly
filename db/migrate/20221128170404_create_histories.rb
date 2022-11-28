class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.float :price
      t.datetime :date_time
      t.references :collection_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
