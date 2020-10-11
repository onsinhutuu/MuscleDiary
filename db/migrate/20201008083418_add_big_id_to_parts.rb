class AddBigIdToParts < ActiveRecord::Migration[5.2]
  def change
    add_column :parts, :big_id, :integer
  end
end
