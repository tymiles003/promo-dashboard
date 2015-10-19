class WebHooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  '''
  Example data:
  {
    "config":
    {
      "action": "test",
      "user_id": "50248397728",
      "endpoint_url": "http://requestb.in/18pae8z1",
      "webhook_id": "22263"
    },
    "api_url": "https://www.eventbriteapi.com/{api-endpoint-to-fetch-object-details}/"
  }
  '''
  def eventbrite
    api_url = params[:api_url]
    order_match = /https:\/\/www\.eventbriteapi\.com\/v\d+\/orders\/(\d+)\/?/i.match(api_url)
    if order_match
      eventbrite_order_id = order_match[1]

      eb = EventbriteAPI.new
      eventbrite_order = eb.get_order(eventbrite_order_id)
      eventbrite_event_id = eventbrite_order['event_id']

      eventbrite_order['attendees'].each do |attendee|
        attendee = eb.get_attendee(eventbrite_event_id, attendee['id'])
        event = Event.find_by_eventbrite_event_id(eventbrite_event_id)
        AttendeeHelper.sync_attendee(event, attendee)
      end

      render plain: 'Order Synced'
    else
      raise 'Invalid Order Input'
    end
  end
end
