module AttendeeHelper

  '''
  Takes an array of eventbrite_attendees and syncs to database.
  Example Attendee data (from eventbrite gem):
  {
    "id": "518287324",
    "event_id": "16113455780",
    "team": null,
    "resource_uri": "https://www.eventbriteapi.com/v3/events/16113455780/eventbrite_attendees/518287324/",
    "changed": "2015-03-29T07:26:48Z",
    "created": "2015-03-29T06:37:07Z",
    "quantity": 1,
    "profile": {
        "first_name": "Danial",
        "last_name": "Afzal",
        "email": "iotasquared@gmail.com",
        "name": "Danial Afzal",
        "addresses": {
            "bill": {
                "city": "San Francisco",
                "region": "CA",
                "postal_code": "94114",
                "address_1": "3630A 17th Street",
                "country": "US"
            }
        }
    },
    "barcodes": [
        {
            "status": "used",
            "changed": "2015-03-29T07:26:48Z",
            "created": "2015-03-29T06:38:28Z",
            "barcode": "410166381518287324001",
            "checkin_type": 1,
            "checkin_method": "search"
        }
    ],
    "answers": [],
    "costs": {
        "payment_fee": {
            "currency": "USD",
            "display": "$0.15",
            "value": 15
        },
        "gross": {
            "currency": "USD",
            "display": "$6.27",
            "value": 627
        },
        "eventbrite_fee": {
            "currency": "USD",
            "display": "$1.12",
            "value": 112
        },
        "tax": {
            "currency": "USD",
            "display": "$0.00",
            "value": 0
        }
    },
    "checked_in": true,
    "cancelled": false,
    "refunded": false,
    "affiliate": null,
    "status": "Checked In",
    "order_id": "410166381",
    "ticket_class_id": "34316609",
    "promotional_code": {
        "id": "149035784",
        "resource_uri": "https://www.eventbriteapi.com/v3/events/16113455780/access_codes/149035784/",
        "promotion": "MISHA",
        "promotion_type": "access",
        "code": "MISHA"
    }
  }
  '''
  def sync_attendees(eventbrite_attendees)
    eventbrite_attendees.each do |eventbrite_attendee|
      if eventbrite_attendee.promotional_code and eventbrite_attendee.promotional_code.promotion_type == 'access'
        eventbrite_attendee_id = eventbrite_attendee.id
        code = eventbrite_attendee.promotional_code.code

        attendee = Attendee.where('eventbrite_attendee_id' => eventbrite_attendee_id).first
        if attendee
          logger.info 'Attendee with eventbrite ID %s already exists with ID %s, skipping' % [eventbrite_attendee_id, attendee.id]
        else
          access_code = AccessCode.where('code' => code).first
          if access_code
            new_attendee = Attendee.new
            new_attendee.access_code_id = attendee.id
            new_attendee.eventbrite_attendee_id = eventbrite_attendee_id
            new_attendee.name = eventbrite_attendee.profile.name
            new_attendee.email = eventbrite_attendee.profile.email
            new_attendee.ordered_at = eventbrite_attendee.created
            new_attendee.save!
          else
            logger.warning 'Order occured with un-synced eventbrite acess code %s' % code
          end
        end
      else
        logger.info 'Skipping attendee who didn\'t use an access code'
      end
    end
  end

end

