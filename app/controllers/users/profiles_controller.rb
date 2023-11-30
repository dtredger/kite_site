class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check

  # TODO - include for current_user
  # https://stackoverflow.com/questions/6902531/how-to-eager-load-associations-with-the-current-user
  def index
    @user = current_user #.includes(:location_map)
  end

  def show
    @user = current_user
  end
end
