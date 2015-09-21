class ProjectsController < ApplicationController	
	before_action :authenticate_user!
	before_action :check_user
	before_action :set_project, only: [:edit, :update, :destroy, :detail_report]
	respond_to :html, :json, only: [:index, :new, :create, :edit, :update, :show, :destroy,:assign_project,:add_users,:reports,:users]
	
	def index
		@projects = current_user.whole_projects
		# if @projects.present?
		# puts "----index"*90
		puts @projects.inspect
			respond_with @projects
		# else
		
		# end	
	end	

	def new 
		@project = Project.new
		respond_with @project
	end

	def categories
		@project = Project.find(params[:id])
		@categories = Category.all
	end

	def checklist
		@project = Project.find(params[:id])
		@reports = @project.reports
		@category = params[:cat]
	end

	def submit_report
		@project = Project.find(params[:id])
		token = Token.find_by_api(params[:authenticity_token])
		user = token.user		
		report = @project.reports.build
		report.name = "#{@project.name} Report #{Date.today.to_s}"
  		report.user_id = user.id
  		report.save!
	    Question.all.each do |q|
	      Answer.create!(question_id: q.id, report_id: report.id, file: nil)		
		end
		return render :json=> report
	end

	def create
		# puts "===="*90
		user_client = current_user.client
		params[:project][:creator_id] = current_user.id 
		@project = user_client.projects.build(params_project)
		
		# @project.user_id = current_user.id
		# @project = user_client.build_projects(params_project)
		if @project.save
			if current_user.role == "client"
				users = params[:project][:userid] if params[:project][:userid].present?
				users && users.each do |user|
					if user != ""
						project_user = ProjectsUsers.new
						project_user.user_id = user.to_i
						project_user.project_id = @project.id
						project_user.save!

						report = @project.reports.build
				  		report.name = "#{@project.name} Report #{Date.today.to_s}"
				  		report.user_id = user.to_i
				  		report.save!
					    Question.all.each do |q|
					      Answer.create!(question_id: q.id, report_id: report.id, file: nil)		
						end
					end	
				end
			end
			# if current_user.role == "user"
				# report = Report.find_by_user_id(current_user.id)
				report = Report.where(user_id: current_user.id, project_id: @project.id).first
				if !report.present?
					report = @project.reports.build
			  		report.name = "#{@project.name} Report #{Date.today.to_s}"
			  		report.user_id = current_user.id
			  		report.save!
				    Question.all.each do |q|
				      Answer.create!(question_id: q.id, report_id: report.id, file: nil)		
					end
				end
				# project_user = ProjectsUsers.find_by_user_id(current_user.id) || ProjectsUsers.new
				project_user = ProjectsUsers.where(user_id:current_user.id, project_id: @project.id).first || ProjectsUsers.new
				project_user.user_id = current_user.id
				project_user.project_id = @project.id
				project_user.save!
			# end
		flash[:notice] = "Project was successfully created." 
		end
		respond_with @project
	end	

	def update_answer
		puts "======="*90
		puts "project"
		answer = Answer.find(params[:id])
		
		answer.notes = params[:answer][:notes]
		answer.file = params[:answer][:file]
		answer.save!
		return render :json=> true
	end

	def show
		# puts "------"*90
		# @categories = Category.all.includes(:questions)
		# @answers = @project.reports.first.answers
		# respond_with :obj => {project: @project, categories: @categories, answers: @answers}
		@category = Category.includes(:questions).where(id: params[:cat]).first
		@project  = Project.find(params[:id])
		@answers = @project.reports.first.answers
		@report = Report.find(params[:rep])
		respond_with :obj => {project: @project, categories: @categories, answers: @answers}
	end	

	def report
		@red_30 = false
		@red_60 = false
		@red_90 = false
		@project = Project.find(params[:id])
		@all_users = ProjectsUsers.where(project_id: params[:id])
		aa = ""
		@all_users.each do |usr|
      		user = User.find(usr.user_id)
      		@uname = user.first_name || user.last_name
      		aa = "#{@uname},#{aa}"
    		end
    		@uname = aa.chomp(",")
		@reports_30 = @project.reports.where("created_at >= ?", Date.today-30.days)
		@days_30 = @reports_30.count
		@reports_30 && @reports_30.each do |rep|
			if rep.answers.where(status: 2).present?
				@red_30 = true
			end
		end
		@reports_60 = @project.reports.where("created_at >= ?", Date.today-60.days)
		@days_60 = @reports_60.count
		@reports_60 && @reports_60.each do |rep|
			if rep.answers.where(status: 2).present?
				@red_60 = true
			end
		end

		# @reportsports_90 = @project.reports.where("created_at >= ? OR created_at< ?", Date.today-90.days,Date.today-90.days)
		@reports_90 = @project.reports
		@days_90 = @reports_90.count
		@reports_90 && @reports_90.each do |rep|
			if rep.answers.where(status: 2).present?
				@red_90 = true
			end
		end		
	end

	def users
		@project = Project.find(params[:id])
		@users = @project.users
		respond_with @users
	end

	def unassign
		@project = Project.find(params[:id])
		proj_user = ProjectsUsers.where(project_id: @project.id, user_id: params[:uid]).first
		proj_user.destroy if proj_user.present?
		flash[:success] = "Unassigned successfully."
		redirect_to users_project_path(@project)
	end

	def edit
		respond_with @project
	end

	def update
    	flash[:notice] = 'Project was successfully updated.' if @project.update(params_project)
    	return render json: :true	
	end

	def destroy
    	respond_with @project.destroy
	end	

	def detail_report
		report = Report.find(params[:report])
  		respond_to do |format|
    		format.html
    		format.json {render :json=> true}
    		format.pdf do
      		pdf = ProjectDetailPdf.new(@project, view_context,report)
      		send_data pdf.render, filename: "(#{@project.name}) project report.pdf", type: "application/pdf", disposition: "attachment"
    		end
 		end
	end

	def assign_project
		@project = Project.find(params[:id])
		@users = current_user.subordinates
		# respond_with @project
	end


	def add_users
		
		id = params[:projectid]
		users = params[:project][:userid] if params[:project][:userid].present?
		project = Project.find(id)
		users && users.each do |user|
			if user != ""
				project_user =  ProjectsUsers.where(user_id: user , project_id: id).first || ProjectsUsers.new
				project_user.user_id = user.to_i
				project_user.project_id = id.to_i
				project_user.save!	
				report = Report.find_by_user_id(user.to_i)
				if !report.present?
					report = project.reports.build
			  		report.name = "#{project.name} Report #{Date.today.to_s}"
			  		report.user_id = user.to_i
			  		report.save!
				    Question.all.each do |q|
				      Answer.create!(question_id: q.id, report_id: report.id, file: nil)		
					end
				end	
			end	
		end
		# respond_with project_user
		respond_to do |format|
	        format.html { redirect_to projects_path, notice: 'Users add successfully.' }
	        format.json { render :json=> true }
	    end
		# flash[:success] = "Users add successfully"
		# redirect_to projects_path		
	end

	private

	def params_project
		params.require(:project).permit(:name, :contact_info, :address, :user_id, :creator_id, :userid)
	end

	def check_user
		# puts "11111"*90
		if current_user.role == 'admin'
			# puts "0000"*90
			flash[:notice] = 'You are not Authorise'
			return redirect_to root_url
		end	
	end	

	def set_project
		@project = current_user.whole_projects.find(params[:id])
	end
end
