module AttendeeHelper

  '''
  Takes an array of attendees and syncs to database.
  Example Attendee data (from eventbrite gem):
  {
    "id": "518287324",
    "event_id": "16113455780",
    "team": null,
    "resource_uri": "https://www.eventbriteapi.com/v3/events/16113455780/attendees/518287324/",
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
  def sync_attendees(attendees)
    attendees.each do |attendee|
      #QSTN: what should we be syncing here?
    end
  end

end

