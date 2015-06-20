class AccessCode < ActiveRecord::Base
  belongs_to :user
  has_many :attendees
end
