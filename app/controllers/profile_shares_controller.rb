class ProfileSharesController < ApplicationController
  def index
    @share_profiles = ProfileShare.all
  end

  def show
  end

  def new
    @share_profile = ProfileShare.new
  end

  def create
    @user = User.find(params[:id])
    @share_profile = ProfileShare.new(user_id: @user.id, current_user_id: current_user.id, shared_at: Time.now)
    if @share_profile.save
      # redirect_to user_path(@user.id), notice: "User shared successfully"
      redirect_to user_path(@user), notice: "User shared successfully"
    else
      render :new
    end
  end

  private

  # def sharing_params
  #   params.require(:user).permit(:current_user, :user_id, :shared_at)
  # end
end
