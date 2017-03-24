class AddEvtadminToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :evtadmin, :boolean, default: false
  end
end
