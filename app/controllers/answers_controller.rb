class AnswersController < ApplicationController

	# before_action :set_project_and_answer, only: [:update]
	respond_to :html, :json
	def update

		@answer = Answer.find(params[:id])
		if @answer.update(status: params[:status])
			if params[:note].present?
				@answer.notes = params[:note]
				@answer.save!
			end 
			return render json: true
		else
			return render json: false
		end
	end

	def check_answer
		answer = Answer.find(params[:id])
		if answer.status == 2
			return render :json=> true
		else
			return render :json=> false
		end
	end

	

	def update_answer
		puts "-------"*90
		puts "answer"
		answer = Answer.find(params[:id])
		
		answer.notes = params[:answer][:notes]
		# answer.remote_file_url = params[:answer][:file]
		answer.file = uploaded_picture(params[:answer][:file]) if params[:answer][:file].present?
		answer.save!
		return render :json=> true
	end
private
	def set_project_and_answer
		@report = Report.find(params[:report])
		# @project = current_user.whole_projects.find(params[:project_id])
		@answer = @report.answers.find(params[:id])
	end

  	def uploaded_picture(base64)

	    tempfile = Tempfile.new ['upload', 'jpg']
	    tempfile.binmode
	    tempfile.write(Base64.decode64(base64))

	    # ActionDispatch::Http::UploadedFile.new(tempfile: tempfile,
	    #   filename: 'upload.jpg')
		tempfile
	end
end
