# == Schema Information
#
# Table name: attendees
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string
#  access_code_id         :integer
#  ordered_at             :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  eventbrite_attendee_id :string
#  gender                 :boolean
#  last_genderize_at      :datetime
#

class Attendee < ActiveRecord::Base
  belongs_to :access_code

  GENDERS = [[0, 'Male'], [1, 'Female']]

  # validates_inclusion_of :gender, :in => GENDERS, :allow_nil => true

  def user
    access_code.user
  end

  def gender_enum
    { 'Male': 0, 'Female': 1 }
  end
end
