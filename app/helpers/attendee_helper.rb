module AttendeeHelper

  '''
  Takes an event and eventbrite_attendee and syncs to database.
  '''
  def self.sync_attendee(event, eventbrite_attendee)
    eventbrite_event_id = event.eventbrite_event_id
    Rails.logger.info 'Syncing attendee %s on eventbrite event %s' % [eventbrite_attendee, eventbrite_event_id]
    if eventbrite_attendee.promotional_code and eventbrite_attendee.promotional_code.promotion_type == 'access'
      # consistently do downcase
      eventbrite_attendee_id = eventbrite_attendee.id

      attendee = Attendee.find_by(eventbrite_event_id: eventbrite_event_id, eventbrite_attendee_id: eventbrite_attendee_id)
      if attendee
        Rails.logger.info 'Attendee with eventbrite ID %s for event %s already exists with ID %s, skipping' % [eventbrite_attendee_id, eventbrite_event_id, attendee.id]
      else
        code = eventbrite_attendee.promotional_code.code.downcase
        access_code = AccessCode.find_by(event: event, code: code)
        if access_code
          new_attendee = Attendee.new
          new_attendee.event_id = event.id
          new_attendee.access_code_id = access_code.id
          new_attendee.eventbrite_attendee_id = eventbrite_attendee_id
          new_attendee.name = eventbrite_attendee.profile.name
          if eventbrite_attendee.profile.respond_to?('email')
            new_attendee.email = eventbrite_attendee.profile.email
          else
            Rails.logger.warn "Missing email for attendee with ID %s" % eventbrite_attendee_id
          end
          new_attendee.ordered_at = eventbrite_attendee.created
          new_attendee.save!
        else
          Rails.logger.warn 'Order occured with un-synced eventbrite acess code %s' % code
        end
      end
    else
      Rails.logger.info 'Skipping attendee who didn\'t use an access code'
    end
  end

end

