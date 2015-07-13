class AddGenderToAttendee < ActiveRecord::Migration
  def change
    # 1 -> F, 2-> M
    add_column :attendees, :gender, :boolean, :null => true
    add_column :attendees, :last_genderize_at, :datetime,  :null => true
  end
end
