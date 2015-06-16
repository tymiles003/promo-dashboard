class EventbriteAPI


  def initialize
    @event_id = 17269742264
    Eventbrite.token = Rails.application.secrets.eventbrite_personal_oauth_token
  end

  #QSTN about eventbrite models, difference between attendee and order, etc.
  '''
  Takes a list of access codes and returns dictionary of Attendees who used them.
  '''
  def get_attendees(user_access_codes)
    attendees = Eventbrite::Attendee.all({ event_id: event_id , expand: 'promotional_code'})

    # If it's paginated then we want to append all those attendees
    all_attendees = attendees.attendees
    if attendees.paginated?
      while attendees.next?
        attendees = Eventbrite::Attendee.all({ page: attendees.next_page, event_id: event_id , expand: 'promotional_code'}).attendees
        all_attendees.concat(attendees)
      end
    end

    user_attendees = {}
    user_access_codes.each do |user_access_code|
      user_attendees[user_access_code] = []
    end

    all_attendees.each do |attendee|
      if user_access_codes.include? attendee.promotional_code
        user_attendees[attendee.promotional_code].concat()
      end
    end
  end


  '''
  Creates an access code, either for a friend (default) or an event_creator
  '''
  def create_access_code(access_code, event_creator = false)

  end


end