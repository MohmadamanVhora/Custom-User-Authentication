class AddColumnsInUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :credit_card, :string
    add_column :users, :cvv, :int
  end
end
