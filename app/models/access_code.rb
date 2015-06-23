class AccessCode < ActiveRecord::Base

  belongs_to :user
  has_many :attendees

  def attendees_referred
    attendees.count
  end
end
