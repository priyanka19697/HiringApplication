class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]

  # GET /applications
  # GET /applications.json
  def index
    @applications = Application.where(status_id:1)
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @application = Application.new
    @status_list = Status.all
    @job_list = Job.all
  end

  # GET /applications/1/edit
  def edit

  end

  # POST /applications
  # POST /applications.json
  def create
    ap = application_params
    ap[:user_id] = current_user.id
    @application = Application.new(ap)

    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: 'Application was successfully created.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    respond_to do |format|

      ap = application_params
      ap[:user_id] = current_user.id
      if @application.update(ap)
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: 'Application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def release_offer
    @application = Application.find(params[:id])
    # @interviewer = User.find_by(params[:interview][:user_id])
    if @application.status.name == "ACCEPTED"
      ScheduleInterviewMailer.release_offer(@application).deliver_now
      flash[:notice] = "Offer released to the candidate"
      redirect_to @application
    else
      flash[:notice] = "Cannot extend an offer when application status is #{@application.status.name}"
      redirect_to @application
    end
  end

  def send_feedback_mail
    @application = Application.find(params[:id])
    # @interviewer = User.find_by(params[:interview][:user_id])
    if @application.status.name == "ACCEPTED"
      ScheduleInterviewMailer.release_offer(@application).deliver_now
      flash[:notice] = "Offer released to the candidate"
      redirect_to @application
    else
      flash[:notice] = "Cannot extend an offer when application status is #{@application.status.name}"
      redirect_to @application
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:name, :email, :mobile, :experience, :resume, :status_id, :job_id, :joining_date, :rejection_reason)
    end
end
