class CreateJoinTableForAccessCodeTypesAndTicketClasses < ActiveRecord::Migration
  def change
    create_join_table :access_code_types, :ticket_classes
  end
end
