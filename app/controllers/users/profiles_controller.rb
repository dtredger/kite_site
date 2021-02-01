class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check

  def index
    @user = current_user
  end

end
