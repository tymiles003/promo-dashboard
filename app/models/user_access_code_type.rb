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
end
