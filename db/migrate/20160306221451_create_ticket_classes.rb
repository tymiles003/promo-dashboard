class CreateTicketClasses < ActiveRecord::Migration
  def change
    create_table :ticket_classes do |t|
      t.integer :eventbrite_ticket_class_id
      t.string :name
      t.text :description
      t.decimal :cost
      t.boolean :donation
      t.boolean :free
      t.datetime :sales_start
      t.datetime :sales_end
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
