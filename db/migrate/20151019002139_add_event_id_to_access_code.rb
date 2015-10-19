class AddEventIdToAccessCode < ActiveRecord::Migration
  def change
    add_reference :access_codes, :event, index: true, foreign_key: true
  end
end
