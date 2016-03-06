class TicketClass < ActiveRecord::Base
  belongs_to :event

  #an access code_type can have multiple ticket_classes it lets you create. and a ticket_class can be created by different access_code_types.
  has_and_belongs_to_many :access_code_types

end
