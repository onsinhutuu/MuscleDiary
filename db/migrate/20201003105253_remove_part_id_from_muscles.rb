class RemovePartIdFromMuscles < ActiveRecord::Migration[5.2]
  def change
    remove_column :muscles, :part_id, :integer
  end
end
