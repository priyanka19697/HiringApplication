class InterviewsController < ApplicationController
  before_action :set_interview, only: [:show, :edit, :update, :destroy]
  # GET /interviews
  # GET /interviews.json
  def index
    @interviews = Interview.all
  end

  # GET /interviews/1
  # GET /interviews/1.json
  def show
    @user_role = current_user.role.name
    return @user_role
  end

  # GET /interviews/new
  def new
    @interview = Interview.new

  end

  # GET /interviews/1/edit
  def edit
  end

  # POST /interviews
  # POST /interviews.json
  def create
        @application = Application.find(params[:interview][:application_id])
        @interviewer = User.find(params[:interview][:user_id])
        @interview = @interviewer.interviews.build(interview_params)
        @interview.application_id = @application.id
        if @interview.save
          ScheduleInterviewMailer.schedule_interview(@interviewer, @application, @interview).deliver_now
          flash[:success] = "Interview created!"
          redirect_to @application
        else
            render 'applications/show'
        end
  end

  # PATCH/PUT /interviews/1
  # PATCH/PUT /interviews/1.json
  def update
    @interview = Interview.find(params[:id])
    old_feeedback = @interview.interview_feedback
    old_status = @interview.status
    message = " "
    respond_to do |format|
      ip = interview_params
      ip[:application_id] = @interview.application_id
      if @interview.update(ip)
        if ip[:status_id] == "3"
          @application = Application.find(ip[:application_id])
          @application.update_attributes(status_id:2)
          @application.save!
          message = send_status_change_email(old_status, old_feeedback) || " "
          message = send_interview_accepted_email(@application) || " "

        end
        format.html { redirect_to @interview, notice: 'Interview was successfully updated. '+ message }
        format.json { render :show, status: :ok, location: @interview }
      else
        format.html { render :edit }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interviews/1
  # DELETE /interviews/1.json
  def destroy
    @interview.destroy
    respond_to do |format|
      format.html { redirect_to interviews_url, notice: 'Interview was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def scheduled_interviews
    @interviewer = User.find(session[:user_id])
    @scheduled_interviews = Interview.where("user_id = #{@interviewer.id} and status_id=3").order(:scheduled_date)
    # redirect_to scheduled_interviews_path
  end

  def assigned_interviews
    @interviewer = User.find(session[:user_id])
    @assigned_interviews = Interview.where(user_id: @interviewer.id, status_id: 1).order(:scheduled_date)
    # redirect_to assigned_interviews_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interview_params
      params.require(:interview).permit(:application_id, :user_id, :scheduled_date, :status_id, :interview_feedback)
    end

    def send_status_change_email(old_status, old_feedback)
      if @interview.status!= old_status || @interview.interview_feedback != old_feedback
        message = "Email was sent about status change"
        # NotificationMailer.status_change_email(@interview).deliver_now
      end
    end

    def send_interview_accepted_email(application)
      # ScheduleInterviewMailer.release_offer(@application).deliver_now
      message = flash[:notice] = ". Candidate has been intimated"
    end
end
