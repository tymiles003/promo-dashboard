class WebHooksController < ApplicationController

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
      order_id = order_match[1]

      eb = EventbriteAPI.new
      attendees = eb.get_order_attendees(order_id)
      AttendeeHelper.sync_attendees(attendees)

      render plain: 'Order Synced'
    else
      raise 'Invalid Order Input'
    end
  end
end
