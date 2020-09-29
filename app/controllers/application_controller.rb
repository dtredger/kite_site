# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def handle_record_not_found
    redirect_to root_url, alert: 'Page Not Found'
  end
end
