module UploadsHelper
	MEGABYTE = 1024.0 * 1024.0
	def bytesToMeg bytes
	  bytes /  MEGABYTE
	end
end
