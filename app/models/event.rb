class Event < ActiveRecord::Base
	has_many :event_categories
    has_many :eventcats, through: :event_categories
    has_many :event_venues
    has_many :venues, through: :event_venues
    has_many :event_attendees
    has_many :attendees, through: :event_attendees
	validates :name, presence: true, length: { minimum:3, maximum: 100 }
    validates :description, presence: true, length: { minimum:10, maximum: 1500 }

end