# == Schema Information
#
# Table name: events
#
#  id                  :integer          not null, primary key
#  title               :string
#  description         :text
#  start_at            :datetime
#  end_at              :datetime
#  eventbrite_event_id :string
#  uses_per_code       :integer
#  eventbrite_url      :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  ticket_class_ids    :string
#

class Event < ActiveRecord::Base
  has_many :ticket_classes
  # Note: I've opted to put a direct connection betewen Event and access_code_types just so its easier to prevent ticket classes from different events being used on same acess code.
  has_many :access_code_types
  has_many :user_access_code_types, :through => :access_code_types
  has_many :access_codes, :through => :user_access_code_types
  has_many :users, :through => :user_access_code_types

  validates :title, :start_at, :end_at, :eventbrite_event_id, :eventbrite_url, presence: true
  validates_format_of :eventbrite_url, :with => URI::regexp(%w(http https))

  default_scope { order('start_at DESC') }

  scope :current_event, -> { where('id' => ENV['CURRENT_EVENT_ID']) }

end
