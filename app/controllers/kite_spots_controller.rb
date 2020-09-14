class KiteSpotsController < ApplicationController
  before_action :set_kite_spot, only: [:show, :edit, :update, :destroy]

  # GET /kite_spots
  # GET /kite_spots.json
  def index
    @kite_spots = KiteSpot.all
  end

  # GET /kite_spots/1
  # GET /kite_spots/1.json
  def show
  end

  # GET /kite_spots/new
  def new
    @kite_spot = KiteSpot.new
    @countries = Country.all
  end

  # GET /kite_spots/1/edit
  def edit
  end

  # POST /kite_spots
  # POST /kite_spots.json
  def create
    @kite_spot = KiteSpot.new(kite_spot_params)

    respond_to do |format|
      if @kite_spot.save
        format.html { redirect_to @kite_spot, notice: 'Kite spot was successfully created.' }
        format.json { render :show, status: :created, location: @kite_spot }
      else
        format.html { render :new }
        format.json { render json: @kite_spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kite_spots/1
  # PATCH/PUT /kite_spots/1.json
  def update
    respond_to do |format|
      if @kite_spot.update(kite_spot_params)
        format.html { redirect_to @kite_spot, notice: 'Kite spot was successfully updated.' }
        format.json { render :show, status: :ok, location: @kite_spot }
      else
        format.html { render :edit }
        format.json { render json: @kite_spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kite_spots/1
  # DELETE /kite_spots/1.json
  def destroy
    @kite_spot.destroy
    respond_to do |format|
      format.html { redirect_to kite_spots_url, notice: 'Kite spot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kite_spot
      @kite_spot = KiteSpot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kite_spot_params
      params.fetch(:kite_spot, {}).permit(:name, :country, :cover_photo)
    end
end
