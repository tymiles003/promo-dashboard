class AddTicketClassIdsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :ticket_class_ids, :string
  end
end
