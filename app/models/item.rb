class Item < ActiveRecord::Base
	belongs_to :customer

	mount_uploader :file1, FileUploader
	mount_uploader :file2, FileUploader
end
