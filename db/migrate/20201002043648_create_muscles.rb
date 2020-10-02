class CreateMuscles < ActiveRecord::Migration[5.2]
  def change
    create_table :muscles do |t|
      t.integer :user_id
      t.text :memo
      t.string :genre
      t.string :set_count
      t.string :weight
      t.string :rep

      t.timestamps
    end
  end
end
