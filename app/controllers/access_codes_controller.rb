class AccessCodesController < ApplicationController
  before_action :require_user_access_code_types

  before_action :authenticate_user!

  # GET /access_codes
  # GET /access_codes.json
  def index
    @access_codes = AccessCode.where(user_access_code_type: @user_access_code_types)
    @access_code = AccessCode.new
  end

  #TODO: update create with @user_access_code_types
  # FUTURE: set this up as ajax
  # POST /access_codes
  # POST /access_codes.json
  def create
    # Simplifies things to only take in lowercase codes
    code = access_code_params[:code].downcase
    user = current_user
    event_id = params[:event_id]
    current_access_codes_count = user.access_codes.where(event_id: event_id).count
    access_code_allowance = @user_event.code_allowance

    if Time.now > @event.end_at
      flash[:error] = 'This event has already started, so you can\'t create access codes for it'
    elsif current_access_codes_count >= access_code_allowance
      flash[:error] = 'You\'re past your access code allowance of %s for this event.  Contact Ben or Andrew for another code.' % access_code_allowance
    else
      begin
        AccessCodesHelper.create_and_sync_access_code(@event, code, current_user.id)
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

    redirect_to event_access_codes_path(@event)
  end

  private
    def require_user_access_code_types
      @event = Event.find params[:event_id]

      @user_access_code_types = @event.user_access_code_types

      # This redirect would happen if they're not associated with tjos evemt
      unless @user_access_code_types.present?
        flash[:alert] = "You aren't associated with that event."
        redirect_to root_path
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_access_code
      @access_code = AccessCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_code_params
      params.require(:access_code).permit(:user_id, :code)
    end
end
