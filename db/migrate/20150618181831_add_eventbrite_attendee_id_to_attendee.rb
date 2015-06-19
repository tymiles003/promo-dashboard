class AddEventbriteAttendeeIdToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :eventbrite_attendee_id, :string
  end
end
