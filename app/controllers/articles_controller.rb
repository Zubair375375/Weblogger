class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [ :index, :show ]

  before_action :set_user

  def index
    @article = Article.all
    @users = User.where.not(id: current_user.id)
    @share_profiles = ProfileShare.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def home
    @article = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    # @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find_by(id: params[:id])

    if @article
      @article.destroy
      flash[:notice] = "Article was successfully deleted."
    else
      flash[:alert] = "Article not found."
    end

    redirect_to root_path, status: :see_other
  end


  private

  def article_params
    params.require(:article).permit(:title, :body, :image, :status)
  end

  def set_user
    @user = current_user # Assuming Devise or similar is being used
  end
end
