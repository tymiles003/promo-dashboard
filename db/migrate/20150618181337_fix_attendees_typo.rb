class FixAttendeesTypo < ActiveRecord::Migration
  def change
    rename_column :attendees, :ordered_art, :ordered_at

  end

end
