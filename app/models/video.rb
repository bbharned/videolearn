class Video < ActiveRecord::Base
	has_many :video_categories
	has_many :categories, through: :video_categories
	validates :name, presence: true, length: { minimum: 5, maximum: 100 }



end