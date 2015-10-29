class UpdateAccessCodesUnique < ActiveRecord::Migration
  def change
    remove_index :access_codes, [:code]
    add_index :access_codes, [:event_id, :code], unique: true
  end
end
