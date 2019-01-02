class Events < ActiveRecord::Migration[5.0]
  def change
  	create_table :events do |t|
        t.string :name
        t.text :description
        t.date :date
        t.datetime :time
        t.integer :cost
        t.timestamps
    end
  end
end
