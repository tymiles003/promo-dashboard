class AddDefaultToUserEvents < ActiveRecord::Migration
  def change
    change_column :user_events, :code_allowance, :integer, :default => 1, :null => false
  end
end
