class Question < ActiveRecord::Base
	has_many :question_answers, dependent: :destroy
	has_many :answers, through: :question_answers

end