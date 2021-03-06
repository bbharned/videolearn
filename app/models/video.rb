class Video < ActiveRecord::Base
	has_many :video_categories
	has_many :categories, through: :video_categories
	has_many :video_quizzes
	has_many :quizzes, through: :video_quizzes
	has_many :user_videos
	has_many :users, through: :user_videos
	validates :name, presence: true, length: { minimum: 5, maximum: 100 }
	accepts_nested_attributes_for :quizzes



end