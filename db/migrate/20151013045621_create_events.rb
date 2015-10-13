class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.integer :eventbrite_event_id
      t.integer :uses_per_code
      t.string :eventbrite_url

      t.timestamps null: false
    end
  end
end
