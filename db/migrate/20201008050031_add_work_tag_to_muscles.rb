class AddWorkTagToMuscles < ActiveRecord::Migration[5.2]
  def change
    add_column :muscles, :work_tag, :string
  end
end
