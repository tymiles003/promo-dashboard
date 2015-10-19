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
end
