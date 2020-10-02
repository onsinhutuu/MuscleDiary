class CreateMuscleComments < ActiveRecord::Migration[5.2]
  def change
    create_table :muscle_comments do |t|
      t.integer :user_id
      t.integer :muscle_id
      t.text :comment

      t.timestamps
    end
  end
end
