class CreateEventcategoriesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :eventcats do |t|
    	t.string :name
    	t.timestamps
    end
  end
end
