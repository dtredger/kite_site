class KiteSpotsController < ApplicationController
  before_action :get_all_kite_spots, only: :index
	before_action :set_kite_spot, only: :show

  # GET /kite_spots
  # GET /kite_spots.json
  def index
  end

  # GET /kite_spots/1
  # GET /kite_spots/1.json
  def show
  end


  private

  def get_all_kite_spots
	  months = params.fetch(:month, {})
	  if months.respond_to?(:length)
		  @valid_months = months & KiteSpot.all_months
		  @kite_spots = KiteSpot.find_tagged_kite_spots(@valid_months)
	  else
			@valid_months = %w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
		  @kite_spots = KiteSpot.all
	  end
  end

  def set_kite_spot
	  @kite_spot = KiteSpot.find(params[:id])
  end

end
