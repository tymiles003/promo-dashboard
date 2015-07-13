namespace :genderize do
  include Genderize

  desc "Sync Attendees with Genderize.io"
  task sync: :environment do
    unsynced_attendees = Attendee.where(:last_genderize_at => nil,:gender => nil)
    unsynced_attendees.each do |unsynced_attendee|
      genderize_response = gender unsynced_attendee.name
      puts "Genderize Response for attendee %s: %s" % genderize_response

      unsynced_attendee.last_genderize_at = Time.now
      unsynced_attendee.gender = genderize_response['gender']

      puts unsynced_attendee
      #unsynced_attendee.save!
    end
  end

end
