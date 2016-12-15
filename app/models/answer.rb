class Answer < ActiveRecord::Base
	has_many :question_answers
	has_many :questions, through: :question_answers
	validates :name, presence: true, length: { minimum: 3, maximum: 100 } 

end