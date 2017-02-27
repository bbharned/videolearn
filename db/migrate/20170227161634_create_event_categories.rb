class CreateEventCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :event_categories do |t|
    	t.integer :event_id
        t.integer :eventcat_id
    end
  end
end
