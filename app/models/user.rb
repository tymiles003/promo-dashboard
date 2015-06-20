class User < ActiveRecord::Base
  has_many :access_codes
end
