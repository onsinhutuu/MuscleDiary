class ChangeColumnsAddNotnullOnMuscles < ActiveRecord::Migration[5.2]
  def change
  	change_column_null :muscles, :rep, false
    change_column_null :muscles, :genre, false
    change_column_null :muscles, :set_count, false
    change_column_null :muscles, :weight, false
    change_column_null :muscles, :memo, false
  end
end
