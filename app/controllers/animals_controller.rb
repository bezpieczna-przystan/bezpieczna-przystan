# frozen_string_literal: true

class AnimalsController < ApplicationController
  before_action :find_animal, only: %i[edit update destroy update_photo]
  before_action :authorize_animal, only: %i[edit update destroy update_photo]

  def index
    @animals = AnimalDecorator.decorate_collection(Animal.all.paginate(page: params[:page], per_page: 6))
    respond_to do |format|
      format.html {}
      format.json { render json: @animals }
    end
  end

  def new
    @url = animals_path
    @animal = Animal.new
    authorize @animal
  end

  def create
    @animal = Animal.new(animal_params)
    authorize @animal
    if @animal.save
      params[:animal][:image_data]&.each do |file|
        @animal.images.create!(image: file)
      end
      flash[:success] = 'Pomyślnie dodano nowego zwierzaczka.'
      redirect_to animals_path
    else
      flash.now[:danger] = 'Nie udało się dodać nowego zwierzątka. Sprawdź błędy i spróbuj ponownie.'
      render :new
    end
  end

  def show
    @animal = Animal.find(params[:id]).decorate
    respond_to do |format|
      format.html {}
      format.json { render json: @animal }
    end
  end

  def edit
    @url = animal_path(@animal)
  end

  def update
    if @animal.update_attributes(animal_params)
      @animal.images.destroy_all
      params[:animal][:image_data]&.each do |file|
        @animal.images.create!(image: file)
      end
      flash[:success] = 'Dane zwierzaka zaktualizowane pomyślnie'
      redirect_to animal_path(@animal)
    else
      render 'edit'
    end
  end

  def update_photo
    @animal.update_attributes(params.permit(:photo))
    redirect_to animal_path
  end

  def destroy
    @animal.destroy
    flash[:success] = 'Zwierzątko zostało usunięte'
    redirect_to animals_path
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :type, :gender, :size, :age,
                                   :purpose, :for_kids, :general_info, :come_date, :vaccination_date,
                                   :sterilization_date, :breed, :photo, image_data: [])
  end

  def find_animal
    @animal = Animal.find(params[:id])
  end

  def authorize_animal
    authorize @animal
  end
end
