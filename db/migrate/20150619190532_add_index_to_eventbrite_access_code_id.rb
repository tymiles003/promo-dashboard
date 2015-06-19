class AddIndexToEventbriteAccessCodeId < ActiveRecord::Migration
  def change
    add_index :access_codes, :eventbrite_access_code_id, unique: true
  end
end
