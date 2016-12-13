class CreateQuizzesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes do |t|
    	t.string :name
    	t.timestamps
    end
  end
end
