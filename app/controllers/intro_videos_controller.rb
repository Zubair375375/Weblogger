class IntroVideosController < ApplicationController
  def index
    @intro_video = IntroVideo.all
  end

  def new
    @introVideo = IntroVideo.new
  end
  
  # def create
  #   @user = IntroVideo.new(video_params)
  #   @introvideo.user_id = current_user.id
  #   @introvideo.save

  #   redirect_to user_path(@introvideo), notice: 'video is successfully uploaded.'
  # end

  def show
  end

  private
  
  def video_params
    params.require(:intro_video).permit(:video)
  end  
end
