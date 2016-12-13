class Quiz < ActiveRecord::Base
	has_many :quiz_questions, dependent: :destroy
	has_many :questions, through: :quiz_questions
	validates :name, presence: true, length: { minimum: 5, maximum: 75 } 
	validates_uniqueness_of :name


end