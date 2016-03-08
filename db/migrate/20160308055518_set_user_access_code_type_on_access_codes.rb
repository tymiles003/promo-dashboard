class SetUserAccessCodeTypeOnAccessCodes < ActiveRecord::Migration
  def change
    AccessCode.all.each do |access_code|
      # Note: this is a backfill, so we assume the dummy User Access Code Types we create were what the Access Codes were
      access_code.user_access_code_type = access_code.user.user_access_code_types.first
      access_code.save!
    end
  end
end
