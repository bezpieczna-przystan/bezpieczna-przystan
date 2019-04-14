# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :find_article, only: %i[show edit update destroy]
  def index
    @articles = Article.paginate(page: params[:page], per_page: 7)
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = 'Post opublikowany'
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @article.update_attributes(article_params)
      flash[:success] = 'Post zaktualizowany'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = 'Post usunięty'
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :photo)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
