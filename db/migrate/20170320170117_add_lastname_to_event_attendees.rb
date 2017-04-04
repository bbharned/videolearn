class AddLastnameToEventAttendees < ActiveRecord::Migration[5.0]
  def change
  	add_column :event_attendees, :lastname, :string
  end
end
