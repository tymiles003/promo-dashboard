class Attendee < ActiveRecord::Base
  belongs_to :access_code
end
