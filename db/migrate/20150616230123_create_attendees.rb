class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :name
      t.string :email
      t.references :access_code, index: true, foreign_key: true
      t.datetime :ordered_art

      t.timestamps null: false
    end
  end
end
