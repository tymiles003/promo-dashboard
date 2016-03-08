class AddAssociationToAccessCodes < ActiveRecord::Migration
  def change
    add_reference :access_codes, :user_access_code_type, index: true, foreign_key: true
  end
end
