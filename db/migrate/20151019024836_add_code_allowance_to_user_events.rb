class AddCodeAllowanceToUserEvents < ActiveRecord::Migration
  def change
    add_column :user_events, :code_allowance, :integer
  end
end
