class Api::V1::KiteSpotsController < ActionController::API

  # TODO - create base APIcontroller to include this in all API controllers
  include DeviseTokenAuth::Concerns::SetUserByToken
  # https://stackoverflow.com/questions/53699878/gem-rack-cors-not-working-and-request-from-angular-client-to-rails-api-throwin
  protect_from_forgery with: :null_session


  # get ?page=2
  def index
    kite_spots = KiteSpot.all.includes(:country).includes([:photos_attachments]).page(pagination_params)
    render json: KiteSpotSerializer.new(kite_spots, meta: { count: KiteSpot.count })
  end

  def show
    kite_spot = KiteSpot.friendly.find(params[:id])
    render json: KiteSpotSerializer.new(kite_spot)
  end


  private

  # TODO: JSON::API creates "page"=>{"number"=>"1", "size"=>"20"}
  def pagination_params
    if params[:page]
      params[:page][:number]
    end
  end

end
