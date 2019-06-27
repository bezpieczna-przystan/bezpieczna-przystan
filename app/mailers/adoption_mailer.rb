# frozen_string_literal: true

class AdoptionMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.adoption_mailer.contact.subject
  #
  def contact(adoption)
    @greeting = "Użytkownik #{adoption.name} jest zainteresowany adopcją psa #{adoption.dog_name}.
                  Oto przesłany przez niego formularz:"
    @name = adoption.name
    @email = adoption.email
    @phone_number = adoption.phone_number
    @where_keep = adoption.where_keep
    @free_time = adoption.free_time
    @children_age = adoption.children_age
    @other_animals = adoption.other_animals
    @had_dog = adoption.had_dog
    @hours_alone = adoption.hours_alone
    @comments = adoption.comments

    mail to: [Rails.application.credentials[:email], 'bezpieczna.przystan.prod@gmail.com'], from: adoption.email
  end

  def preferences_form(adoption)
    @greeting = "Użytkownik #{adoption.name} poszukuje psa.
                  Oto przesłany przez niego formularz preferencji:"
    @name = adoption.name
    @email = adoption.email
    @phone_number = adoption.phone_number
    @gender = adoption.gender
    @dog_size = adoption.dog_size
    @where_keep = adoption.where_keep
    @free_time = adoption.free_time
    @children_age = adoption.children_age
    @other_animals = adoption.other_animals
    @had_dog = adoption.had_dog
    @hours_alone = adoption.hours_alone
    @comments = adoption.comments

    mail to: [Rails.application.credentials[:email], 'bezpieczna.przystan.prod@gmail.com'], from: adoption.email
  end
end
