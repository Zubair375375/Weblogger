class UsersController < ApplicationController
  before_action :authenticate_user!

  # user_signed_in?

  # current_member

  # member_session

  before_action :set_user, only: %i[ show edit update destroy intro_video ]
  # before_action :set_user, only: [:intro_video]


  # GET /users or /users.json
  def index
    @users = User.all
    @article = Article.new  # Initializes a new article object
    @articles = Article.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user_articles = @user.articles
    @intro_video = @user.intro_video

    @comment =  UserComment.where(intro_video_id: @intro_video)
  end

  # GET /users/new
  def new
    @user = User.new
  end
  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.with(user: @user).welcome_email.deliver_now

        format.html { redirect_to(@user, notice: "User was successfully created.") }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

    # respond_to do |format|
    #   if @article.save
    #     @articles = Article.all
    #     format.turbo_stream
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #   end
    # end
  end

  def follow
    @user = User.find(params[:id])
    Follow.create(follower: current_user, followed: @user)

    respond_to do |format|
      format.html { redirect_to @user }
    end
  end

  def unfollow
    @user = User.find(params[:id])
    follow_relationship = Follow.find_by(follower: current_user, followed: @user)
    if follow_relationship
      follow_relationship.destroy
    end

    respond_to do |format|
      format.html { redirect_to @user }
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    Rails.logger.debug("Params: #{params.inspect}")
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @intro_video = IntroVideo.find_by(user_id: current_user.id)
    if @intro_video
      @intro_video.destroy
    end

    current_user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def cover_image
    @user = User.find(params[:user_id])
    @cvr_image = @user.cover_image
    @cvr_image.destroy!

    redirect_to user_path(@user), notice: "Cover image was successfully deleted."
  end

  def intro_video
    @intro_video = IntroVideo.new
  end

  def create_intro_video
    @user = User.find(params[:id])

    if @intro_video.present?
      @intro_video.destroy
        redirect_to user_path(current_user), notice: "Video deleted."
    end

    @introvideo = IntroVideo.new(video_params)
    @introvideo.user_id = current_user.id
    if @introvideo.save
      redirect_to user_path(@introvideo.user_id), notice: "Video was successfully uploaded."
    else
      flash.now[:alert] = "There was a problem uploading your video."
      render :intro_video
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def video_params
      params.require(:intro_video).permit(:video, :user_id)
    end

    def user_params
      params.require(:user).permit(:name, :email, :login, :avatar, :bio, :cover_image, :country, :state, :follower, :following, :comments)
    end
end
