class UserMailerPreview < ActionMailer::Preview
  
  def event_confirmation
    UserMailer.event_confirmation(Attendee.first, Event.first)
  end

end