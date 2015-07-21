module AttendeeHelper

  '''
  Takes an array of eventbrite_attendees and syncs to database.
  '''
  def self.sync_attendees(eventbrite_attendees)
    eventbrite_attendees.each do |eventbrite_attendee|
      Rails.logger.info 'Syncing attendee %s' % eventbrite_attendee
      if eventbrite_attendee.promotional_code and eventbrite_attendee.promotional_code.promotion_type == 'access'
        eventbrite_attendee_id = eventbrite_attendee.id
        # consistently do downcase
        code = eventbrite_attendee.promotional_code.code.downcase

        attendee = Attendee.where('eventbrite_attendee_id' => eventbrite_attendee_id).first
        if attendee
          Rails.logger.info 'Attendee with eventbrite ID %s already exists with ID %s, skipping' % [eventbrite_attendee_id, attendee.id]
        else
          access_code = AccessCode.where('code' => code).first
          if access_code
            new_attendee = Attendee.new

            new_attendee.access_code_id = access_code.id
            new_attendee.eventbrite_attendee_id = eventbrite_attendee_id
            new_attendee.name = eventbrite_attendee.profile.name
            if eventbrite_attendee.profile.has_key?('email')
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

end

