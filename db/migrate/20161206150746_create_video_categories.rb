class CreateVideoCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :video_categories do |t|
    	t.integer :video_id
    	t.integer :category_id
    end
  end
end
