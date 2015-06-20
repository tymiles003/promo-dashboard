class RemoveInviteeFieldsFromAccessCodes < ActiveRecord::Migration
  def change
    remove_column :access_codes, :invitee_name, :string
    remove_column :access_codes, :invitee_url, :string
    remove_column :access_codes, :invitee_info, :text
  end
end
