class RemoveGenreFromMuscles < ActiveRecord::Migration[5.2]
  def change
    remove_column :muscles, :genre, :string
  end
end
