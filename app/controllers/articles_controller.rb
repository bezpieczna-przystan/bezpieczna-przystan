# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :find_article, only: %i[show edit update destroy update_photo]
  before_action :authorize_article, only: %i[edit update destroy update_photo]
  def index
    @articles = ArticleDecorator.decorate_collection(Article.all.paginate(page: params[:page], per_page: 7))
    respond_to do |format|
      format.html {}
      format.json { render json: @articles }
    end
  end

  def show
    respond_to do |format|
      format.html {}
      format.json { render json: @article }
    end
  end

  def new
    @article = Article.new
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    authorize @article
    if @article.save
      params[:article][:image_data]&.each do |file|
        @article.images.create!(image: file)
      end
      flash[:success] = 'Post opublikowany'
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @article.update_attributes(article_params)
      @article.images.destroy_all
      params[:article][:image_data]&.each do |file|
        @article.images.create!(image: file)
      end
      flash[:success] = 'Post zaktualizowany'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def update_photo
    @article.update_attributes(params.permit(:photo))
    redirect_to article_path
  end

  def destroy
    @article.destroy
    flash[:success] = 'Post usunięty'
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, image_data: [])
  end

  def find_article
    @article = Article.find(params[:id])
  end

  def authorize_article
    authorize @article
  end
end
