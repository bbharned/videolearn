class Event < ActiveRecord::Base
	has_many :event_categories
    has_many :eventcats, through: :event_categories
	validates :name, presence: true, length: { minimum:3, maximum: 100 }
    validates :description, presence: true, length: { minimum:10, maximum: 1500 }

end