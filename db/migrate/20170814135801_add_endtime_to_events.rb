class AddEndtimeToEvents < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :endtime, :datetime
  end
end
