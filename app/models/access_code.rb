# == Schema Information
#
# Table name: access_codes
#
#  id                        :integer          not null, primary key
#  user_id                   :integer
#  code                      :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  eventbrite_access_code_id :string
#  event_id                    :integer
#

class AccessCode < ActiveRecord::Base

  belongs_to :user
  has_many :attendees
  belongs_to :event

  validates :user_id, :code, :event_id, :eventbrite_access_code_id, presence: true

  scope :current_event, -> { where('event_id' => ENV['CURRENT_EVENT_ID']) }

  def attendees_referred
    attendees.count
  end
end
