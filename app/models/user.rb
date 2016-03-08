# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  password               :string
#  code_allowance         :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  admin                  :boolean          default(FALSE)
#  first_name             :string
#  last_name              :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :user_access_code_types
  has_many :access_code_types, :through => :user_access_code_types
  has_many :access_codes, :through => :user_access_code_types
  has_many :events, -> { distinct }, :through => :access_code_types
  has_many :attendees, :through => :access_code

  has_many :current_event_user_access_code_types, -> {current_event}, :class_name => 'UserAccessCodeType'
  has_many :current_event_access_codes, -> { current_event }, :class_name => 'AccessCode'
  has_many :current_event_attendees, -> { current_event }, :class_name => 'Attendee', :source => :attendees, :through => :access_codes

  scope :current_event, -> { includes(:access_code_types).where('access_code_type.event_id' => ENV['CURRENT_EVENT_ID']) }

  validates :email, presence: true

  def full_name
    '%s %s' % [first_name, last_name]
  end

  def codes_created
    access_codes.count
  end

  def females_referred
    attendees.where(gender: true).count
  end

  def attendees_referred
    attendees.count
  end

  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end
end
