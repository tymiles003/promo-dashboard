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

  validates :access_code_type, :user, presence: true

  def event
    access_code_type.event
  end

  def to_s
    if access_code_type
      access_code_type.name + ' (' + user.full_name + ')'
    else
      super
    end
  end

  after_initialize :default_values
  def default_values
    if !self.allowance && access_code_type && access_code_type.default_allowance
      self.allowance = access_code_type.default_allowance
    end
  end
end
