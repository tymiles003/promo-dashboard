class AddEventbriteEventIdToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :eventbrite_event_id, :string
  end
end
