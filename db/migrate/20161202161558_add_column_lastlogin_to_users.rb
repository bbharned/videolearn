class AddColumnLastloginToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :lastlogin, :datetime
  end
end
