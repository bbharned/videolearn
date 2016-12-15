class Question < ActiveRecord::Base
	has_many :question_answers, dependent: :destroy
	has_many :answers, through: :question_answers
	has_many :quiz_questions
	has_many :quizzes, through: :quiz_questions

end