class CreateMuscleTags < ActiveRecord::Migration[5.2]
  def change
    create_table :muscle_tags do |t|
      t.integer :muscle_id, null: false
      t.string :tag_id, null: false

      t.timestamps
    end
  end
end
