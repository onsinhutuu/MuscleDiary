class AddUserIdToParts < ActiveRecord::Migration[5.2]
  def change
  	 add_column :parts, :user_id, :integer
  end
end
