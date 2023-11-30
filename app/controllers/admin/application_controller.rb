# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin

    def authenticate_admin
      redirect_to root_path, alert: 'Not Authorized' unless current_user && current_user.admin?

      admin_name = Rails.application.credentials.dig(:admin, :name)
      admin_pw = Rails.application.credentials.dig(:admin, :password)
      
      if admin_name.blank? || admin_pw.blank?
        redirect_to root_path, alert: 'Credentials Not Set'
      else
        http_basic_authenticate_or_request_with name: admin_name, password: admin_pw
      end
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
