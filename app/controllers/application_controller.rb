# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_raven_context
  include Pundit
  protect_from_forgery
  # after_action :verify_authorized, except: %i[index show]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
