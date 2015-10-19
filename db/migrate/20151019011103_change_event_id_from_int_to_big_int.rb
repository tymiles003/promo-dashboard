class ChangeEventIdFromIntToBigInt < ActiveRecord::Migration
  def change
    change_column :events, :eventbrite_event_id, :bigint
  end
end
