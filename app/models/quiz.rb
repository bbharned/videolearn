class Quiz < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 5, maximum: 75 } 
	validates_uniqueness_of :name


end