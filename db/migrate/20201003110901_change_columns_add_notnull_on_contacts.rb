class ChangeColumnsAddNotnullOnContacts < ActiveRecord::Migration[5.2]
  def change
  	change_column_null :contacts, :title, false
    change_column_null :contacts, :body, false
    change_column_null :contacts, :reply, false
  end
end
