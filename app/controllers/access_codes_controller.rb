class AccessCodesController < ApplicationController
  before_action :require_user_access_code_types

  before_action :authenticate_user!

  # GET /access_codes
  # GET /access_codes.json
  def index
    #TODO: determine how/what we're going to serve to get the user's ticket classes and acess_code_types
    @access_codes = AccessCode.where(user_access_code_type: @user_access_code_types)
    @access_code = AccessCode.new

    # access code types available to this user.
    @access_code_types = current_user.access_code_types.where(event: @event)
    # only show ticket classes available to the user via their access code types
    @ticket_classes = TicketClass.joins('INNER JOIN access_code_types_ticket_classes ON access_code_types_ticket_classes.ticket_class_id = ticket_classes.id').where('access_code_types_ticket_classes.access_code_type_id': @access_code_types).distinct.order('sales_start ASC, cost ASC')

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

    user_access_code_type = @user_access_code_types.where(access_code_type: access_code_params[:access_code_type_id]).first

    if user_access_code_type.present?
      current_access_codes_count = user.access_codes.where(user_access_code_type: user_access_code_type).count
      access_code_allowance = user_access_code_type.allowance

      if Time.now > @event.end_at
        flash[:error] = 'This event has already started, so you can\'t create access codes for it'
      elsif current_access_codes_count >= access_code_allowance
        flash[:error] = 'You\'re reached your allowance of %s.  Contact Ben or Andrew for a higher code allowance.' % ActionController::Base.helpers.pluralize(access_code_allowance, user_access_code_type.access_code_type.name)
      else
        begin
          AccessCodesHelper.create_and_sync_access_code( user_access_code_type, code, current_user)
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
    else
      flash[:error] = 'You don\'t have permission to create codes of this type'
    end

    redirect_to event_access_codes_path(@event)
  end

  private
    def require_user_access_code_types
      @event = Event.find params[:event_id]

      @user_access_code_types = @event.user_access_code_types.where(user: current_user)

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
      params.require(:access_code).permit(:access_code_type_id, :code)
    end
end
