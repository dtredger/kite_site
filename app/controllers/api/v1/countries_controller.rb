class Api::V1::CountriesController < ActionController::API

  # TODO - create base APIcontroller to include this in all API controllers
  include DeviseTokenAuth::Concerns::SetUserByToken
  # https://stackoverflow.com/questions/53699878/gem-rack-cors-not-working-and-request-from-angular-client-to-rails-api-throwin
  protect_from_forgery with: :null_session


  # before_action :authenticate_user!

  # get ?page=2
  def index
    countries = Country.all.includes(:kite_spots).includes([:photos_attachments]).page(params[:page])
    render json: CountrySerializer.new(countries)
  end

  def show
    country = Country.friendly.find(params[:id])

      options = {include: [:kite_spots]}
    render json: CountrySerializer.new(country, options)
  end

end
