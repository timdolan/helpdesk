class ArticlesController < ApplicationController
  before_filter :admin_user, :except => [:index, :show, :search]
  
  uses_tiny_mce
    
  def index
    @article = Article.all
    @title = "Articles"
  end

  def show
    @article = Article.find(params[:id])
    @title = @article.title
  end
  
  def new
    @title = "Add Article"
    @article = Article.new
  end
  
  def create
    @article = Article.new(params[:article])
    @article.user_id = current_user.id
    if @article.save
      flash[:success] = "New article added"
      redirect_to @article
    else
      @title = "Add Article"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit Article"
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    @article.user_id = current_user.id
    if @article.update_attributes(params[:article])
      flash[:success] = "Article updated"
      redirect_to @article
    else
      @title = "Edit Article"
      render 'edit'
    end
  end
  
  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "Article deleted."
    redirect_to articles_path 
  end
    
  def search
    @article = Article.search(params[:article][:search])
    render 'index'
  end
  
end