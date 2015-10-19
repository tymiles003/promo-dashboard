class AddDefaultToUserEventsTakeTwo < ActiveRecord::Migration
  def change
    change_column :user_events, :code_allowance, :integer, :default => 1
  end
end
