class Answer < ActiveRecord::Base
	has_many :question_answers
	has_many :questions, through: :question_answers

end