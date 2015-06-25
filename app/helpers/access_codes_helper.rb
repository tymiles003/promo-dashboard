module AccessCodesHelper

  #TODO: authorization
  '''
  Creates the provided access code for the user.
  Returns the created Access Code upon success, otherwise raises a CreateCodeError error along the way.
  '''
  #TODO: validate access_code allowance here, since it's lowest level.
  def self.create_and_sync_access_code(access_code, user_id)

    # Begin by validating the code they sent
    validate_access_code!(access_code)

    eb = EventbriteAPI.new

    access_code = eb.create_access_code(access_code)

    new_access_code = AccessCode.new
    new_access_code.user_id = user_id
    new_access_code.code = access_code['code']
    new_access_code.eventbrite_access_code_id = access_code['id']

    new_access_code.save!

  end

  '''
  Pre-API request validation of access codes.

  Raises an error if the access code is:
    -Too Short
    -Too Long
    -Already exists in the DB
  '''
  def self.validate_access_code!(access_code)

    # Spaces, apostrophes and non-alphanumeric characters (except '-', '_', '@' and '.') are not allowed.
    if !/^[-_@.\w]+$/.match(access_code)
      raise Exceptions::InvalidCodeCharacters
    end

    if access_code.length < 5
      raise Exceptions::CodeTooShortError
    elsif access_code.length > 30
      raise Exceptions::CodeTooLongError
    end

    existing_access_code = AccessCode.where(code: access_code)
    if existing_access_code.first
      raise Exceptions::CodeAlreadyCreatedError
    end
  end
end