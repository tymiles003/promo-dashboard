class EventbriteAPI

  def initialize
    @event_id = 16113455780
    Eventbrite.token = Rails.application.secrets.eventbrite_personal_oauth_token
  end

  '''
  Takes an Order created on Eventbrite and grabs its Attendees from API.
  Returns list of Attendees.
  '''
  def get_order_attendees(order_id)
    order_attendees = []

    order = Eventbrite::Order.retrieve(order_id)
    if order
      order.attendees.each do |attendee|
        attendee_id = attendee.id
        attendee = Eventbrite::Attendee.retrieve(@event_id, attendee_id)
        if attendee
          order_attendees.push(attendee)
        else
          raise 'Failed to grab attendee %s' % attendee_id
        end
      end
    else
      raise 'Could not retrieve order %s' % order_id
    end

    order_attendees
  end

  def create_access_code(access_code)
    #TODO write this
  end


end