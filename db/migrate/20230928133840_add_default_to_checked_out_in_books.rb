class AddDefaultToCheckedOutInBooks < ActiveRecord::Migration[7.0]
  def change
    change_column_default :books, :checked_out, from: nil, to: false
  end
end
