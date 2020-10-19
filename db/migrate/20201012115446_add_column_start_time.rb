class AddColumnStartTime < ActiveRecord::Migration[5.2]
  def change
    add_column :muscles, :start_time, :datetime
  end
end
