# frozen_string_literal: true

class KiteSpotsController < ApplicationController
  load_and_authorize_resource #cancancan before_action

  before_action :set_kite_spot, only: %i[show edit update destroy]


  def index
    set_kite_spots
  end

  def show; end

  def new
    @kite_spot = KiteSpot.new
  end

  def edit; end

  def create
    @kite_spot = KiteSpot.new(kite_spot_params)
    if @kite_spot.save
      redirect_to @kite_spot, notice: 'Kite Spot was successfully created.'
    else
      render :new
    end
  end

  def update
    if @kite_spot.update(kite_spot_params)
      redirect_to @kite_spot, notice: 'Kite Spot was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @kite_spot.destroy
    redirect_to kite_spots_url, notice: 'Kite Spot was successfully destroyed.'
  end

  private

  # TODO: - move to model ; params are url-params ; includes for query
  def set_kite_spots
    if month_params.empty?
      @valid_months = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
      @kite_spots = KiteSpot.all.includes([:photos_attachments]).includes(:country).page(params[:page])
    else
      @valid_months = month_params & KiteSpot.all_months
      @kite_spots = KiteSpot.find_months(@valid_months).includes(:country).page(params[:page])
    end
  end

  def set_kite_spot
    @kite_spot = KiteSpot.friendly.find(params[:id])
  end

  def kite_spot_params
    params.fetch(:kite_spot).permit(:name, :content, :latitude, :longitude, :description, :country_id,
                                    month_tag_list: [], photos: [])
  end

  def month_params
    params.fetch(:month, {})
  end
end
