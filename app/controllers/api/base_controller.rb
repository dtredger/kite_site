# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    # TODO: - create base APIcontroller to include this in all API controllers
    # include DeviseTokenAuth::Concerns::SetUserByToken
    # https://stackoverflow.com/questions/53699878/gem-rack-cors-not-working-and-request-from-angular-client-to-rails-api-throwin

    # protect_from_forgery with: :null_session

    # TODO: - remove this
    skip_forgery_protection
  end
end
