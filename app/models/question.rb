class Question < ActiveRecord::Base
	has_many :question_answers, dependent: :destroy
	has_many :answers, through: :question_answers
	has_one :quiz_question
	has_one :quiz, through: :quiz_questions

end