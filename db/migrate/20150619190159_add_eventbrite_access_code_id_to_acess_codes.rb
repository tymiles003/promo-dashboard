class AddEventbriteAccessCodeIdToAcessCodes < ActiveRecord::Migration
  def change
    add_column :access_codes, :eventbrite_access_code_id, :string
  end
end
