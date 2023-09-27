class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :book_id
      t.string :patron_name
      t.string :transaction_type
      t.datetime :transaction_date

      t.timestamps
    end
  end
end
