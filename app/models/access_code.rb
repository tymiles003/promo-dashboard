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
#

class AccessCode < ActiveRecord::Base

  belongs_to :user
  has_many :attendees

  def attendees_referred
    attendees.count
  end
end
