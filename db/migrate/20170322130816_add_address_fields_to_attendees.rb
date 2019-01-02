class AddAddressFieldsToAttendees < ActiveRecord::Migration[5.0]
  def change
  	add_column :attendees, :street, :string
  	add_column :attendees, :street2, :string
  	add_column :attendees, :city, :string
  	add_column :attendees, :state, :string
  	add_column :attendees, :zip, :integer
  end
end
