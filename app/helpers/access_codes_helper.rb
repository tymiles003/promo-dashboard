module AccessCodesHelper

  #TODO: authorization
  '''
  Creates the provided access code for the user.
  Returns the created Access Code upon success, otherwise raises an error along the way.
  '''
  #TODO: validate access_code allowance here, since it's lowest level.
  def self.create_and_sync_access_code(access_code, user_id)

    existing_access_code = AccessCode.where(code: access_code)
    if existing_access_code.first
      Rails.logger.warn 'Access code %s already exists' % access_code
      return existing_access_code.first
    else
      eb = EventbriteAPI.new
      access_code = eb.create_access_code(access_code)
      new_access_code = AccessCode.new
      new_access_code.user_id = user_id
      new_access_code.code = access_code['code']
      new_access_code.eventbrite_access_code_id = access_code['id']

      new_access_code.save!
    end


  end

end
