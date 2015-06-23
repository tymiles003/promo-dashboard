class Attendee < ActiveRecord::Base
  belongs_to :access_code

  def user
    access_code.user
  end
end
