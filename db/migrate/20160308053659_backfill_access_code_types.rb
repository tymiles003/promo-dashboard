class BackfillAccessCodeTypes < ActiveRecord::Migration
  def change
    Event.all.each do |event|
      AccessCodeType.create!(event: event, name: 'Ticket', default_allowance: 5)
    end
  end
end
