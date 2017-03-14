class Attendee < ActiveRecord::Base
	has_many :event_attendees
    has_many :events, through: :event_attendees
    validates :firstname, presence: true, length: { minimum: 1, maximum: 20 }
    validates :lastname, presence: true, length: { minimum: 2, maximum: 30 }
    validates :company, presence: true, length: { minimum: 2, maximum: 80 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
    validates :email,  presence: true,  length: { maximum: 105 },
                uniqueness: { case_sensitive: false },
                format: { with: VALID_EMAIL_REGEX }
    before_save { self.email = email.downcase }

end