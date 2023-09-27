class CreateBookIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :book_issues do |t|
      t.string :patron_name
      t.integer :book_id
      t.date :issued_date
      t.date :due_date
      t.boolean :returned

      t.timestamps
    end
  end
end
