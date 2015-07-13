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
