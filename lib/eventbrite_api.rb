  class EventbriteAPI

    def initialize
      @event_id = 16113455780
      Eventbrite.token = Rails.application.secrets.eventbrite_personal_oauth_token
    end

    #QSTN about eventbrite models, difference between attendee and order, etc.
    '''
    Takes a list of access codes and returns dictionary of Attendees who used them.
    '''
    def get_attendees_for_access_codes(access_codes)
      # Initialize return dictionary with access codes as keys
      attendees_for_access_codes = {}
      access_codes.each do |user_access_code|
        attendees_for_access_codes[user_access_code.downcase] = []
      end

      all_attendees = get_all_attendees

      all_attendees.each do |attendee|
        print attendee.promotional_code
        if attendee.promotional_code and attendee.promotional_code.promotion_type == 'access'
          attendee_access_code = attendee.promotional_code.promotion.downcase
          if access_codes.include? attendee_access_code
            attendees_for_access_codes[attendee_access_code].append(attendee)
          end
        end
      end

      attendees_for_access_codes
    end

  '''
  Returns all attendees
  '''
  def get_all_attendees()
    attendees = Eventbrite::Attendee.all({ event_id: @event_id , expand: 'promotional_code'})

    # If it's paginated then we want to append all those attendees
    all_attendees = attendees.attendees
    if attendees.paginated?
      threads = []
      print attendees.page_count
      while attendees.next?
        threads << Thread.new do
          attendees = Eventbrite::Attendee.all({ page: attendees.next_page, event_id: @event_id, expand: 'promotional_code'})
        end

        all_attendees.concat(attendees.attendees)
      end
    end

    all_attendees
  end


  '''
  Creates an access code, either for a friend (default) or an event_creator
  '''
  def create_access_code(access_code, event_creator = false)

  end


end