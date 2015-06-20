module AttendeeHelper

  '''
  Takes an array of eventbrite_attendees and syncs to database.
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

