class CreateUserAccessCodeTypes < ActiveRecord::Migration
  def change
    create_table :user_access_code_types do |t|
      t.references :user, index: true, foreign_key: true
      t.references :access_code_type, index: true, foreign_key: true
      t.integer :allowance

      t.timestamps null: false
    end
  end
end
