class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :access_codes
  has_many :attendees, :through => :access_codes, :source=> :attendees

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
