class Category < ActiveRecord::Base
	has_many :video_categories
	has_many :videos, through: :video_categories
	validates :name, presence: true, length: { minimum: 3, maximum: 25 } 
	validates_uniqueness_of :name
end