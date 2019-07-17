class AddDeletedAtToTourDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :tour_details, :deleted_at, :datetime
    add_index :tour_details, :deleted_at
  end
end
