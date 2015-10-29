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
  has_many :user_events
  has_many :users, :through => :user_events
  has_many :access_codes

  validates :title, :start_at, :end_at, :eventbrite_event_id, :uses_per_code, :eventbrite_url, :ticket_class_ids, presence: true
  validates_numericality_of(:uses_per_code, greater_than: 0, only_integer: true)
  validates_format_of :eventbrite_url, :with => URI::regexp(%w(http https))

  default_scope { order('start_at DESC') }

  scope :halloween, -> { where('id' => 1) }

end
