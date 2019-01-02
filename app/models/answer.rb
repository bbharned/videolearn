class Answer < ActiveRecord::Base
	has_many :question_answers
	has_many :questions, through: :question_answers
	validates :name, presence: true, length: { minimum: 1, maximum: 200 } 

end