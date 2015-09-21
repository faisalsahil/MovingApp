class Report < ActiveRecord::Base

	belongs_to :project
	has_many :answers, dependent: :destroy
end
