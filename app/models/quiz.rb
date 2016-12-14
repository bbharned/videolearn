class Quiz < ActiveRecord::Base
	has_many :quiz_questions, dependent: :destroy
	has_many :questions, through: :quiz_questions
	has_one :video_quiz
	has_one :video, through: :video_quiz
	validates :name, presence: true, length: { minimum: 5, maximum: 75 } 
	validates_uniqueness_of :name


end