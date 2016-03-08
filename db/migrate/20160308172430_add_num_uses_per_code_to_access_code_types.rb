class AddNumUsesPerCodeToAccessCodeTypes < ActiveRecord::Migration
  def change
    add_column :access_code_types, :num_uses_per_code, :integer
  end
end
