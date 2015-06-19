class AddIndexes < ActiveRecord::Migration
  def change
    add_index :access_codes, :code, unique: true
    add_index :attendees, :eventbrite_attendee_id, unique: true
  end
end
