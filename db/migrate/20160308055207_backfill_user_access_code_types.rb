class BackfillUserAccessCodeTypes < ActiveRecord::Migration
  def change
    UserEvent.all.each do |user_event|
      # Backfill-- so we assume the first is the only one.
      UserAccessCodeType.create!(user: user_event.user, access_code_type: user_event.event.access_code_types.first, allowance: user_event.code_allowance)
    end
  end
end
