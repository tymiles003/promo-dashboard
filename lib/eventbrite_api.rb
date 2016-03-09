class EventbriteAPI

  def initialize
    Eventbrite.token = ENV['eventbrite_personal_oauth_token']
  end

  '''
  Takes an Order created on Eventbrite and grabs its Attendees from API.
  Returns list of Attendees.
  '''
  def get_order(eventbrite_order_id)
    order = Eventbrite::Order.retrieve(id: eventbrite_order_id, expand: 'event,attendees')
    if order
      order
    else
      raise 'Could not retrieve order %s' % eventbrite_order_id
    end
  end

  def get_attendee(eventbrite_event_id, eventbrite_attendee_id)
    attendee = Eventbrite::Attendee.retrieve(eventbrite_event_id, id: eventbrite_attendee_id, expand: 'promotional_code')
    if attendee
      attendee
    else
      raise 'Could not retrieve attendee %s from event %s' % [eventbrite_attendee_id, eventbrite_event_id]
    end
  end

  '''
  Creates an access_code on Eventbrite.
  Returns the created access code, otherwise raises the error.
  '''
  def create_access_code(event, access_code_type, access_code)
    agent = Mechanize.new
    headers = {'Authorization' => 'Bearer ' + ENV['eventbrite_personal_oauth_token']}
    endpoint = '/events/%s/access_codes/' % event.eventbrite_event_id
    ticket_class_ids = access_code_type.ticket_classes.map {|t| t.eventbrite_ticket_class_id}.join(',')
    post_query = {
            'access_code.code': access_code,
            'access_code.ticket_ids': ticket_class_ids,
            'access_code.quantity_available': access_code_type.num_uses_per_code
    }
    begin
      eventbrite_response = agent.post(Eventbrite.api_url(endpoint), post_query, headers)
      JSON.parse(eventbrite_response.body)
    rescue Exception => e
      raise Exceptions::EventbriteCodeCreationError.new(e.message)
    end
  end
end