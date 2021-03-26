# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  check_authorization unless: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def handle_record_not_found
    redirect_to root_url, alert: 'Page Not Found'
  end

  rescue_from CanCan::AccessDenied do |_exception|
    if current_user.nil?
      session[:next] = request.fullpath
      redirect_to new_user_session_path, alert: 'You have to log in to continue.'
    else
      # render file: "#{Rails.root}/public/403.html", status: 403
      redirect_back(fallback_location: root_path)
    end
  end
end
