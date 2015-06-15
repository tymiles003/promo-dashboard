class CreateAccessCodes < ActiveRecord::Migration
  def change
    create_table :access_codes do |t|
      t.references :user, index: true, foreign_key: true
      t.string :code
      t.string :invitee_name
      t.string :invitee_url
      t.text :invitee_info

      t.timestamps null: false
    end
  end
end
