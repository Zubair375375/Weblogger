class UserCommentsController < ApplicationController
  before_action :set_user_comment, only: [ :destroy, :show ]
  def index
    @user_comments = UserComments.all
  end
  def new
    @user_comment = UserComments.new
  end

  def show
    @user = User.find(params[:id])
    @user_comments = @user.user_comments

    redirect_to users_path(@user)
  end

  def create
    user = User.find(params[:user_id])
    @intro_video = user.intro_video
    @user_comment = @intro_video.user_comments.new(comment_params)

    @user_comment.user_id = current_user.id

    if @user_comment.save
      redirect_to user_path(user), notice: "Comment was successfully created."
    else
      render :new
    end
  end


  # Delete a comment
  def destroy
    @user_comment = current_user.user_comments
    @user_comment.destroy(set_user_comment)
    redirect_to user_user_comment_path(@user_comment, @user_comment.intro_video), notice: "Comment was successfully deleted."
  end

  def reaction
    @user_comment = UserComment.find params[:user_comment_id]
    @reaction = @user_comment.reactions.create(user_id: current_user.id, user_comment_id: @user_comment.id)
    # binding.break
    @reaction.save!
    redirect_to user_path(@user_comment)
  end


  def unreacted
    @user_comment = UserComment.find(params[:user_comment_id])

    # Find the reaction if it exists, and destroy it
    # @reaction = React.find(reactor_id: current_user.id, user_comment_id: @user_comment.id)
    @reaction =  @user_comment.reactions.find_by(user_id: current_user.id, user_comment_id: @user_comment.id)
    if @reaction
      @reaction.destroy
    end

    redirect_to user_path(@user_comment.user)
  end

  private

  def set_user_comment
    @user_comment = UserComment.find(params[:id])
  end

  def comment_params
    params.require(:user_comment).permit(:content, :user_id, :intro_video_id) # Adjust fields as necessary
  end
end
