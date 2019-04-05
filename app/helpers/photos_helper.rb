module PhotosHelper
	def flash_photo_size
	  flash[:danger] = "Photo should be less than 5MB"
	end
end
