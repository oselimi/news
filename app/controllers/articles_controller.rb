class ArticlesController < ApplicationController
  before_action :set_params, only: [:edit, :update, :show, :destroy]
  before_action :require_same_article, only: [:edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Article successfully deleted"
      redirect_to articles_path
    end
  end

  private

  def article_params
    params.require(:article).permit(:name, :description)
  end

  def set_params
    @article = Article.find(params[:id])
  end

  def require_same_article
    if current_user != @article.user
      flash[:notice] = "You are not competent for this article"
      redirect_to articles_path
    end
  end
end
