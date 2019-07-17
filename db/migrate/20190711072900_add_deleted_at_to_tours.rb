class AddDeletedAtToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :deleted_at, :datetime
    add_index :tours, :deleted_at
  end
end
