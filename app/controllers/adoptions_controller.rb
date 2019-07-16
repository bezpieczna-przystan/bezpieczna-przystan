# frozen_string_literal: true

class AdoptionsController < ApplicationController
  invisible_captcha only: %i[create send_preferences], honeypot: :subtitle
  before_action :find_animal, only: %i[new create]
  def new
    @adoption = DogAdoption.new
  end

  def create
    @adoption = DogAdoption.new(adoption_params)
    if @adoption.valid?
      AdoptionMailer.contact(@adoption).deliver_now
      redirect_to animal_path(@animal)
      flash[:notice] = 'Dziękujemy za Twoją wiadomość, odezwiemy się najszybciej jak to możliwe.'
    else
      flash[:notice] = 'Nie udało się przesłać formularza. Sprawdź błędy i spróbuj ponownie.'
      render :new
    end
  end

  def new_preferences
    @adoption = PreferencesForm.new
  end

  def send_preferences
    @adoption = PreferencesForm.new(preferences_params)
    if @adoption.valid?
      AdoptionMailer.preferences_form(@adoption).deliver_now
      redirect_to root_path
      flash[:notice] = 'Dziękujemy za Twoją wiadomość, odezwiemy się gdy znajdziemy psiaka idealnego dla Ciebie :-)'
    else
      flash[:notice] = 'Nie udało się przesłać formularza. Sprawdź błędy i spróbuj ponownie.'
      render :new
    end
  end
end

def adoption_params
  params.require(:dog_adoption).permit(:name, :email, :phone_number, :where_keep, :free_time, :children_age,
                                       :other_animals, :had_dog, :hours_alone, :dog_name, :comments)
        .merge!(dog_name: @animal.name)
end

def preferences_params
  params.require(:preferences_form).permit(:name, :gender, :dog_size, :email, :phone_number, :where_keep, :free_time, :children_age,
                                           :other_animals, :had_dog, :hours_alone, :dog_name, :comments)
end

def find_animal
  @animal = Animal.find(params[:animal_id]).decorate
end
