class AddDeletedAtToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :deleted_at, :datetime
  end
end
