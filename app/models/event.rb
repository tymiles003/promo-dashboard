# == Schema Information
#
# Table name: events
#
#  id                  :integer          not null, primary key
#  title               :string
#  description         :text
#  start_at            :datetime
#  end_at              :datetime
#  eventbrite_event_id :integer
#  uses_per_code       :integer
#  eventbrite_url      :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Event < ActiveRecord::Base
  has_many :user_events
  has_many :users, :through => :user_events

  default_scope { order('start_at DESC') }

end
