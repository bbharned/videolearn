class Venue < ActiveRecord::Base
    has_many :event_venues
    has_many :events, through: :event_venues
    validates :name, presence: true, length: {minimum: 3, maximum: 75}
    validates_uniqueness_of :name

end