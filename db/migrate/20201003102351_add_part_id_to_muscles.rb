class AddPartIdToMuscles < ActiveRecord::Migration[5.2]
  def change
    add_column :muscles, :part_id, :integer
  end
end
