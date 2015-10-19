class ChangeEventIdFromIntegerToString < ActiveRecord::Migration
  def change
    change_column :events, :eventbrite_event_id, :string
  end
end
