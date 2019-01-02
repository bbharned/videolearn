class AddCellCarrierToAttendees < ActiveRecord::Migration[5.0]
  def change
  	add_column :attendees, :carrier, :string
  end
end
