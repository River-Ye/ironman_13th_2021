class AddUniqueToShops < ActiveRecord::Migration[6.1]
  def change
    add_index :shops, :name, unique: true
  end
end
