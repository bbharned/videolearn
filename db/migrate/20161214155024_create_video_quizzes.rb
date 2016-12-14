class CreateVideoQuizzes < ActiveRecord::Migration[5.0]
  def change
    create_table :video_quizzes do |t|
    	t.integer :video_id
    	t.integer :quiz_id
    	t.timestamps
    end
  end
end
