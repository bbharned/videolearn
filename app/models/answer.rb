class Answer < ActiveRecord::Base
	has_one :video_categories
	has_one :question, through: :question_answers

end