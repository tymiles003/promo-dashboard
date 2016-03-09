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
#  event_id                  :integer
#  user_access_code_type_id  :integer
#

class AccessCode < ActiveRecord::Base
  belongs_to :user_access_code_type
  has_many :attendees

  belongs_to :user

  validates :user_id, :code, :event_id, :eventbrite_access_code_id, presence: true

  scope :current_event, -> { where('event_id' => ENV['CURRENT_EVENT_ID']) }

  def access_code_type
    user_access_code_type.access_code_type
  end

  def attendees_referred
    attendees.count
  end
end
