class AddHideOnDashboardToTicketClasses < ActiveRecord::Migration
  def change
    add_column :ticket_classes, :hide_on_dashboard, :boolean
  end
end
