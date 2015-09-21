class ReportsController < ApplicationController
	respond_to :html, :json
	def index
		id = []
		@good_report = []
		@project = Project.find(params[:project_id])
		@reports = @project.reports.order("created_at ASC")
		@reports.each do |rep|
			if !rep.answers.where(status: [0,2,3]).present?
				id << rep.id
			end	
		end
		if id.length > 0
			# puts "000"*90
			@reports = @project.reports.where.not(id: id)			
			@good_report = @project.reports.where(id: id)
		end
		# @answers = @project.reports.answers
		respond_with :obj => {:@project=> @project,:@reports=>@reports, :@good_report=> @good_report }
		# respond_with
	end


	def get_answer
		# @question = Question.find(params[:question_id])
		@answers  = Answer.where(question_id: params[:question_id], report_id: params[:id])
		# @answers  = @question.answers
		respond_with @answers
	end

	def getanswerid
		answer  = Answer.where(question_id: params[:question_id], report_id: params[:id])
		# @answers  = @question.answers
		respond_with answer
	end

	def destroy
		report = Report.find(params[:id])
		report.destroy
		@project = Project.find(params[:project_id])
		respond_to do |format|
	        format.html { redirect_to project_reports_path(@project), success: 'Users add successfully.' }
	        format.json { render :json=> true }
	    end
	end

	def show
		@report = Report.find(params[:id])
		@project = @report.project
		@categories = Category.all.includes(:questions)
		@answers = @report.answers
		# respond_with :obj => {project: @project, categories: @categories, answers: @answers}
	end

	def answers
		@report = Report.find(params[:id])
		@answers = @report.answers
		respond_with @answers
	end

	def detail_report
		@report = Report.find(params[:id])
  		respond_to do |format|
    		format.html
    		format.json { render :json=> true} 
    		format.pdf do
      		pdf = ReportDetailPdf.new(@report, view_context)
      		send_data pdf.render, filename: "(#{@report.name}) report.pdf", type: "application/pdf", disposition: "attachment"
    		end
 		end
	end
end

