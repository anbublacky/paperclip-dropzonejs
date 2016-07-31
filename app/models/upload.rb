class Upload < ActiveRecord::Base
	belongs_to :music
	has_attached_file :image, 
					  :styles => { :medium => "300x300>",:thumb => "100x100>" }

  	validates_attachment :image, 
  						 :presence => true,
  						 :content_type => { :content_type => /\Aimage\/.*\Z/ }
  	validate :image_present

	def image_present
	  if image.present? && music.uploads.map {|image| image.image_file_size}.sum + image_file_size > 10.megabytes
	    errors.add(:image, "Limit of 10MB has been reached.")
	  end
	end
end

