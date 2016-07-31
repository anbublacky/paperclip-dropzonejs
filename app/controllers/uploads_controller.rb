class UploadsController < ApplicationController
  def new
    @upload = Upload.new
    @music = Music.create
  end

  def create
    @upload = Upload.create(upload_params)
    if @upload.save
      # send success header
      render json: { message: "success", fileID: @upload.id }, :status => 200
    else
      #  you need to send an error header, otherwise Dropzone
      #  will not interpret the response as an error:
      render json: { error: @upload.errors.full_messages.join(',')}, :status => 400
    end     
  end

  def destroy
    @upload = Upload.find(params[:id])
    if @upload.destroy    
      render json: { message: "File deleted from server" }
    else
      render json: { message: @upload.errors.full_messages.join(',') }
    end
  end

  def progress_limit
    @music = Music.find_by_id(params["music_id"])
    respond_to do |format|
      format.js
    end
  end

  private
  def upload_params
    params.require(:upload).permit(:image, :music_id)
  end
end
