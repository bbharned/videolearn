class UserMailer < ApplicationMailer
    default from: 'ThinManager Video Learning'
 
  def password_reset(user)
    @user = user
    #@url  = 'https://thinmanager.com'
    delivery_options = { address: 'smtp.gmail.com',
                         port: 587,
                         user_name: 'bharned@thinmanager.com',
                         password: password,
                         authentication: 'plain',
                         enable_starttls_auto: true
                          }
    mail(to: @user.email, from: 'ThinManager Video Learning', subject: 'Password Reset', delivery_method_options: delivery_options)
  end


  def event_confirmation(attendee, event)
    @attendee = attendee
    @event = event
    delivery_options = { address: 'smtp.gmail.com',
                         port: 587,
                         user_name: 'bharned@thinmanager.com',
                         password: password,
                         authentication: 'plain',
                         enable_starttls_auto: true
                          }
    mail(to: @attendee.email, from: 'ThinManager Events', subject: 'Event Registration Confirmation', delivery_method_options: delivery_options)
  end


  
  private
      def password
        password = "Corv3tt3"
      end
end