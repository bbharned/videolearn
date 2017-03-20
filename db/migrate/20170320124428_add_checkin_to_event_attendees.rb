class AddCheckinToEventAttendees < ActiveRecord::Migration[5.0]
  def change
  	add_column :event_attendees, :checkedin, :boolean, default: false
  end
end
