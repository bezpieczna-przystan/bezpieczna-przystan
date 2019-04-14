# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  it 'has a valid factory' do
    expect(FactoryBot.create(:article)).to be_valid
  end

  let(:article) { FactoryBot.create(:article) }
  subject { article }

  describe 'GET #index' do
    before :each do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it "populates an array of articles" do
      expect(assigns(:articles)).to eq([article])
    end

    it "renders the :index view" do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, params: { id: article.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested article to @article" do
      expect(assigns(:article)).to eq(article)
    end

    it "renders the :show view" do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the :new view" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it 'create new article' do
        expect { post :create, params: { article: {
                                  title: "Perfect title for perfect article",
                                  body: "Perfect body for perfect article",
                                  photo: "article.png" }}}.to change {Article.count}.by(1)
      end

      it "redirects to the new article" do
        post :create, params: { article: {
                                  title: "Perfect title for perfect article",
                                  body: "Perfect body for perfect article",
                                  photo: "article.png" }}
        expect(response).to redirect_to articles_path
      end
    end

    context "with invalid attributes" do
      it 'create new article' do
        expect { post :create, params: { article: {
                                  title: nil,
                                  body: nil,
                                  photo: nil }}}.to_not change {Article.count}
      end

      it 're-renders the new method' do
        post :create, params: { article: {
                                title: nil,
                                body: nil,
                                photo: nil }}
        expect(response).to render_template :new

      end
    end
  end

  describe 'GET #edit' do
    before :each do
      get :edit, params: { id: article.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested article to @article" do
      expect(assigns(:article)).to eq(article)
    end

    it "renders the :edit view" do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    before :each do
      @article = FactoryBot.create(:article)
    end

    context "with valid attributes" do
      it "located the requested @article" do
        put :update, params: { id: @article.id, article: {
                                title: "Another perfect title for perfect article",
                                body: "Another perfect body for perfect article",
                                photo: "updated_article.jpg" }}
        expect(assigns(:article)).to eq(@article)
      end

      it "changes @article's attributes" do
        put :update, params: { id: @article.id, article: {
                                title: "Even better title for perfect article",
                                body: "Even better body for perfect article",
                                photo: "better_article.jpg" }}
        @article.reload
        expect(@article.title).to eq("Even better title for perfect article")
        expect(@article.body).to eq("Even better body for perfect article")
        expect(@article.photo).to eq("better_article.jpg")
      end

      it "redirects to the updated article" do
        put :update, params: { id: @article.id, article: {
                                title: "Even better title for perfect article",
                                body: "Even better body for perfect article",
                                photo: "better_article.jpg" }}
        expect(response).to redirect_to @article
      end
    end

    context "with invalid attributes" do
      it "does not change @article's attributes" do
        put :update, params: { id: @article.id, article: {
                                title: nil,
                                body: "Too short",
                                photo: "No format" }}
        expect(@article.title).to_not eq(nil)
        expect(@article.body).to_not eq("Too short")
        expect(@article.photo).to_not eq("No format")
      end

      it "re-renders the edit method" do
        put :update, params: { id: @article.id, article: {
                                title: nil,
                                body: "Too short",
                                photo: "No format" }}
        expect(response).to render_template :edit
      end
    end


  end

  describe 'DELETE #destroy' do
    before :each do
      @article = FactoryBot.create(:article)
    end

    it "deletes the article" do
      expect {
        delete :destroy, params: { id: @article.id }
      }.to change{ Article.count }.by(-1)
    end

    it "redirects to articles#index" do
      delete :destroy, params: { id: @article.id }
      expect(response).to redirect_to articles_path
    end
  end
end
