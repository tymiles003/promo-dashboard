module Exceptions
  class CreateCodeError < StandardError; end
  class CodeAlreadyCreatedError < CreateCodeError; end
  class InvalidCodeCharacters < CreateCodeError; end
  class CodeTooShortError < CreateCodeError; end
  class CodeTooLongError < CreateCodeError; end
  class EventbriteCodeCreationError < CreateCodeError; end
end