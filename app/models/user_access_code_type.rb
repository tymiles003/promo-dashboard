# == Schema Information
#
# Table name: user_access_code_types
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  access_code_type_id :integer
#  allowance           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class UserAccessCodeType < ActiveRecord::Base
  belongs_to :user
  belongs_to :access_code_type

  has_many :access_codes

  scope :current_event, -> { includes(:access_code_type).where('access_code_types.event_id' => ENV['CURRENT_EVENT_ID']) }

  def event
    access_code_type.event
  end

  after_initialize :default_values
  def default_values
    if access_code_type && access_code_type.default_allowance
      self.allowance = access_code_type.default_allowance
    end
  end
end
