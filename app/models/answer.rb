class Answer < ActiveRecord::Base
	has_one :question_answer
	has_one :question, through: :question_answer

end