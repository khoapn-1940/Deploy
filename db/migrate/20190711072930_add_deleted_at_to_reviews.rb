class AddDeletedAtToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :deleted_at, :datetime
    add_index :reviews, :deleted_at
  end
end
