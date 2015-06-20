class AccessCodesController < ApplicationController
  before_action :set_access_code, only: [:show, :edit, :update, :destroy]

  # GET /access_codes
  # GET /access_codes.json
  def index
    #TODO: use auth here and elsewhere
    @user = User.find(1)
    @code_allowance = @user.code_allowance
    @access_codes = AccessCode.where(user_id: @user.id)
    @access_code = AccessCode.new
    @eventbrite_event_url = ENV['eventbrite_event_url']

  end

  # GET /access_codes/1
  # GET /access_codes/1.json
  def show
  end

  # GET /access_codes/1/edit
  def edit
  end

  # POST /access_codes
  # POST /access_codes.json
  def create
    #TODO: use eventbrite_api function for this, with error handling here.
    #TODO: send API request
    #TODO: handle fails
      # END_IN_PAST
      # END_TOO_LATE
      # INVALID_TICKET_IDS
      # START_AFTER_END
      # START_IN_PAST
      # START_TOO_LATE
    #TODO: use access_coes_helper to actually sync the access code upon creation
    #TODO: Return response to spec
    @access_code = AccessCode.new(access_code_params)

    respond_to do |format|
      if @access_code.save
        format.html { redirect_to @access_code, notice: 'Access code was successfully created.' }
        format.json { render :show, status: :created, location: @access_code }
      else
        format.html { render :new }
        format.json { render json: @access_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_codes/1
  # PATCH/PUT /access_codes/1.json
  def update
    respond_to do |format|
      if @access_code.update(access_code_params)
        format.html { redirect_to @access_code, notice: 'Access code was successfully updated.' }
        format.json { render :show, status: :ok, location: @access_code }
      else
        format.html { render :edit }
        format.json { render json: @access_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_codes/1
  # DELETE /access_codes/1.json
  def destroy
    @access_code.destroy
    respond_to do |format|
      format.html { redirect_to access_codes_url, notice: 'Access code was successfully destroyed.' }
      format.json { head :no_content }
    end
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
