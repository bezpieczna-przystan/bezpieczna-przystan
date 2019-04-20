# frozen_string_literal: true

class DogAdoption
  include ActiveModel::Model

  attr_accessor :name, :email, :phone_number, :where_keep, :free_time, :children_age,
                :other_animals, :had_dog, :hours_alone, :dog_name, :comments, :animal_id
  validates :name, :email, :where_keep, :free_time, :children_age,
            :other_animals, :had_dog, :hours_alone, presence: true
  validates :phone_number, numericality: { only_integer: true }
  validates :email, email: true
end
