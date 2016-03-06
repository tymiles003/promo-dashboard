class CreateAccessCodeTypes < ActiveRecord::Migration
  def change
    create_table :access_code_types do |t|
      t.references :event, index: true, foreign_key: true
      t.string :name
      t.integer :default_allowance

      t.timestamps null: false
    end
  end
end
