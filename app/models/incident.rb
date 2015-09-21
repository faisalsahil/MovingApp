class Incident < ActiveRecord::Base
	belongs_to :project

	validates_presence_of :report_type
	validates_presence_of :your_name
	validates_presence_of :job_title
	validates_presence_of :injury_date
	validates_presence_of :injury_time
	validates_presence_of :location
	validates_presence_of :injuries_type

	mount_uploader :file, FileUploader

end
