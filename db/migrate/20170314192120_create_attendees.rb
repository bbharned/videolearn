class CreateAttendees < ActiveRecord::Migration[5.0]
  def change
    create_table :attendees do |t|
    	t.string :firstname
    	t.string :lastname
    	t.string :company
    	t.string :email
    	t.string :relationship
    	t.timestamps
    end
  end
end
