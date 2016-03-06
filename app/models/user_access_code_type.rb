class UserAccessCodeType < ActiveRecord::Base
  belongs_to :user
  belongs_to :access_code_type

  has_many :access_codes
end
