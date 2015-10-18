class AccessCodesController < ApplicationController
  before_action :set_access_code, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!

  # GET /access_codes
  # GET /access_codes.json
  def index
    #TODO: use auth here and elsewhere
    @user = current_user
    @code_allowance = @user.code_allowance
    @access_codes = AccessCode.where(user_id: @user.id)
    @access_code = AccessCode.new
    @eventbrite_event_url = ENV['eventbrite_event_url']

  end

  # FUTURE: set this up as ajax
  # POST /access_codes
  # POST /access_codes.json
  def create

    # Simplifies things to only take in lowercase codes
    code = access_code_params[:code].downcase
    user_id = current_user.id
    user = User.find(user_id)
    current_access_codes_count = user.access_codes.count
    access_code_allowance = user.code_allowance

    if current_access_codes_count >= access_code_allowance
      flash[:error] = 'You\'re past your access code allowance of %s.  Contact Ben or Andrew for another code.' % access_code_allowance
    else
      begin
        AccessCodesHelper.create_and_sync_access_code(code, user_id)
        flash[:success] = 'Successfully created access code %s' % access_code_params[:code]
      rescue Exceptions::InvalidCodeCharacters
        flash[:error] = "Spaces, apostrophes and non-alphanumeric characters (except '-', '_', '@' and '.') are not allowed in access codes."
      rescue Exceptions::CodeTooShortError
        flash[:error] = "The code you entered is too short."
      rescue Exceptions::CodeTooLongError
        flash[:error] = "The code you entered is too long."
      rescue Exceptions::CodeAlreadyCreatedError
        flash[:error] = 'The code you entered is unavailable because it\'s already been created.'
      rescue Exceptions::EventbriteCodeCreationError => ex
        flash[:error] = 'There was a problem creating this code on eventbrite: %s' % ex.message
      rescue Exception => ex
        flash[:error] = 'Unexpected error: %s' % ex.message
      end
    end

    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_access_code
      @access_code = AccessCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_code_params
      params.require(:access_code).permit(:user_id, :code)
    end
end
