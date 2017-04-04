class ChangeEventsTable < ActiveRecord::Migration[5.0]
  def change
  	remove_column :events, :date, :date
    add_column :events, :capacity, :integer
  end
end
