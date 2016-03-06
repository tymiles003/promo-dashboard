class AccessCodeType < ActiveRecord::Base
  belongs_to :event

  has_and_belongs_to_many :ticket_classes
  has_and_belongs_to_many :users, :through => :user_access_code_types
end
