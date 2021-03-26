class Api::V1::CountriesController < Api::BaseController
  # get ?page=2
  def index
    countries = Country.all.includes(:kite_spots).includes([:photos_attachments]).page(params[:page])
    render json: CountrySerializer.new(countries)
  end

  def show
    country = Country.friendly.find(params[:id])

    options = { include: [:kite_spots] }
    render json: CountrySerializer.new(country, options)
  end
end
