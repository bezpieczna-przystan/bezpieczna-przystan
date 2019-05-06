# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    !!user
  end

  def new?
    !!user
  end

  def update?
    !!user
  end

  def edit?
    !!user
  end

  def destroy?
    !!user
  end

  def update_photo?
    !!user
  end
end
