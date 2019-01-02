class AddNumberToAttendees < ActiveRecord::Migration[5.0]
  def change
  	add_column :attendees, :phone, :integer
  end
end
