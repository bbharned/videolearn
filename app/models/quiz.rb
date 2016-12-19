class Quiz < ActiveRecord::Base
	has_many :quiz_questions
	has_many :questions, through: :quiz_questions
	has_many :video_quizzes
	has_many :videos, through: :video_quizzes
	validates :name, presence: true, length: { minimum: 5, maximum: 75 } 
	validates_uniqueness_of :name
	accepts_nested_attributes_for :questions


end