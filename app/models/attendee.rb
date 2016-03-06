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
#  eventbrite_event_id    :string
#  event_id               :integer
#

class Attendee < ActiveRecord::Base
  #TODO: add eventbrite_event_id to this one as well
    #TODO: update the uniqueness constraint
  belongs_to :access_code
  belongs_to :event

  validates :name, :access_code_id, :ordered_at, :eventbrite_attendee_id, presence: true

  GENDERS = [[0, 'Male'], [1, 'Female']]

  scope :current_event, -> { includes(:access_code).where('access_codes.event_id' => ENV['CURRENT_EVENT_ID']) }
  # validates_inclusion_of :gender, :in => GENDERS, :allow_nil => true

  def user
    access_code.user
  end

  def gender_enum
    { 'Male': 0, 'Female': 1 }
  end
end
