# == Schema Information
#
# Table name: user_events
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  event_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  code_allowance :integer
#

class UserEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user_id, :event_id, :code_allowance, presence: true

  scope :current_event, -> { where('event_id' => ENV['CURRENT_EVENT_ID']) }

  after_initialize :default_values
  def default_values
    self.code_allowance ||= 5
  end

end
