# == Schema Information
#
# Table name: access_code_types
#
#  id                :integer          not null, primary key
#  event_id          :integer
#  name              :string
#  default_allowance :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  num_uses_per_code :integer
#

class AccessCodeType < ActiveRecord::Base
  belongs_to :event

  has_many :user_access_code_types
  has_and_belongs_to_many :ticket_classes
  has_and_belongs_to_many :users, :through => :user_access_code_types

  after_initialize :default_values
  def default_values
    self.default_allowance ||= 2
  end
end
