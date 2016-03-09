# == Schema Information
#
# Table name: ticket_classes
#
#  id                         :integer          not null, primary key
#  eventbrite_ticket_class_id :integer
#  name                       :string
#  description                :text
#  cost                       :decimal(, )
#  donation                   :boolean
#  free                       :boolean
#  sales_start                :datetime
#  sales_end                  :datetime
#  event_id                   :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class TicketClass < ActiveRecord::Base
  belongs_to :event

  #an access code_type can have multiple ticket_classes it lets you create. and a ticket_class can be created by different access_code_types.
  has_and_belongs_to_many :access_code_types

  has_many :user_access_code_types, :through => :access_code_types

  validates :name, :event, :eventbrite_ticket_class_id, presence: true

end
