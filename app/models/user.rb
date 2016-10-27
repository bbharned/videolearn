class User < ActiveRecord::Base
    #attr_accessor :password_confirmation, :email_confirmation 
    validates :firstname, presence: true, length: { minimum: 1, maximum: 20 }
    validates :lastname, presence: true, length: { minimum: 3, maximum: 20 }
    validates :password, confirmation: true, :on => :create
    validates :email, confirmation: true, :on => :create
    validates :email_confirmation, presence: true, :on => :create
    validates :password_confirmation, presence: true, :on => :create
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
    validates :email,  presence: true,  length: { maximum: 105 },
                uniqueness: { case_sensitive: false },
                format: { with: VALID_EMAIL_REGEX }

    has_secure_password

end