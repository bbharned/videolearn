class CreateUserVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_videos do |t|
    	t.integer :user_id
    	t.integer :video_id
    	t.timestamps
    end
  end
end
