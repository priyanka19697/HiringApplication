class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]

  # GET /applications
  # GET /applications.json
  def index
    @applications = Application.all
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @application = Application.new
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
      old_date = @application.joining_date
      ap = application_params
      ap[:user_id] = current_user.id
      if @application.update(ap)
        new_date = @application.joining_date
        flag = check_if_joining_date_changed(old_date, new_date)
        if flag || ap[:rejection_reason] != ""
          redirect_to thankyou_path
          break
        elsif @application.application_status == "GO-CLOSED" || @application.application_status == "NO-GO-CLOSED"
          send_feedback_mail
          return
        end
        format.html { redirect_to interviewer_path, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: interviewer_path }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_final
    respond_to do |format|
      ap = application_params
      ap[:user_id] = current_user.id
      if @application.update(ap)
        format.html { redirect_to thankyou_path, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: thankyou_path }
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

  def open_applications
    @applications = Application.where(application_status:"OPEN")
  end

  def inprogress_applications
    @applications = Application.where(application_status:"IN PROGRESS")
  end

  def accepted_applications
    @applications = Application.where(application_status:"GO-CLOSED")
  end

  def rejected_applications
    @applications = Application.where(application_status:"NO-GO-CLOSED")
  end

  def show_feedback_page
    @application = Application.find(params[:id])
  end

  def give_feedback_page
    @application = Application.find(params[:id])
    respond_to do |format|
      if @application.update(feedback_params)
        format.html { redirect_to thankyou_path, notice: 'Feedback was successfully given' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def release_offer
    @application = Application.find(params[:id])
    # @interviewer = User.find_by(params[:interview][:user_id])
    if @application.application_status == "GO-CLOSED"
      ScheduleInterviewMailer.release_offer(@application).deliver_now
      flash[:notice] = "Offer released to the candidate"
      redirect_to @application
    else
      flash[:notice] = "Cannot extend an offer when application status is #{@application.application_status}"
      redirect_to @application
    end
  end

  def send_feedback_mail
    @application = Application.find(params[:id])
    ScheduleInterviewMailer.feedback_mail(@application).deliver_now
    flash[:notice] = "feedback mail to the candidate"
    redirect_to @application
  end

  def accept_offer
     @application = Application.find(params[:id])
  end

  def reject_offer
     @application = Application.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:name, :email, :mobile, :experience, :resume, :application_status, :job_id, :joining_date, :rejection_reason)
    end

    def feedback_params
      params.require(:application).permit(:interviewee_feedback)
    end

    def check_if_joining_date_changed(old_date, new_date)
      if old_date != new_date
        return true
      end
      return false
    end
end
