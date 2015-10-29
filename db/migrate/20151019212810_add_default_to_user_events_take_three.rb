class AddDefaultToUserEventsTakeThree < ActiveRecord::Migration
  def change
    change_column :user_events, :code_allowance, :integer, :default => 5
  end
end
