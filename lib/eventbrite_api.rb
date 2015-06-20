class EventbriteAPI

  def initialize
    @event_id = ENV['event_id']
    @ticket_class_ids = ENV['ticket_class_ids']
    @uses_per_access_code = ENV['uses_per_access_code']
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
        attendee = Eventbrite::Attendee.retrieve(@event_id, id: attendee_id, expand: 'promotional_code')
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

  '''
  Creates an access_code on Eventbrite.
  Returns the created access code, otherwise raises the error.
  '''
  def create_access_code(access_code)
    agent = Mechanize.new
    headers = {'Authorization' => 'Bearer ' + ENV['eventbrite_personal_oauth_token']}
    endpoint = '/events/%s/access_codes/' % @event_id
    post_query = {
            'access_code.code': access_code,
            'access_code.ticket_ids': @ticket_class_ids,
            'access_code.quantity_available': @uses_per_access_code
    }
    begin
      eventbrite_response = agent.post(Eventbrite.api_url(endpoint), post_query, headers)
      JSON.parse(eventbrite_response.body)
    rescue Exception => e
      raise Exceptions::EventbriteCodeCreationError(e.message)
    end
  end


end