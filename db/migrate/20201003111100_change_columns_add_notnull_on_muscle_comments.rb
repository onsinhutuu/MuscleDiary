class ChangeColumnsAddNotnullOnMuscleComments < ActiveRecord::Migration[5.2]
  def change
  	change_column_null :muscle_comments, :comment, false
  end
end
