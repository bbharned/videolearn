class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
    	t.string :name
    	t.boolean :correct, default: false
    	t.timestamps
    end
  end
end
