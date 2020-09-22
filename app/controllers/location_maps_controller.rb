class LocationMapsController < ApplicationController
  before_action :set_location_map, only: [:show, :edit, :update, :destroy]

  # GET /location_maps
  # GET /location_maps.json
  def index
    @location_maps = LocationMap.all
  end

  # GET /location_maps/1
  # GET /location_maps/1.json
  def show
  end

  # GET /location_maps/new
  def new
    @location_map = LocationMap.new
  end

  # GET /location_maps/1/edit
  def edit
  end

  # POST /location_maps
  # POST /location_maps.json
  def create
    @location_map = LocationMap.new(location_map_params)

    respond_to do |format|
      if @location_map.save
        format.html { redirect_to @location_map, notice: 'Location map was successfully created.' }
        format.json { render :show, status: :created, location: @location_map }
      else
        format.html { render :new }
        format.json { render json: @location_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /location_maps/1
  # PATCH/PUT /location_maps/1.json
  def update
    respond_to do |format|
      if @location_map.update(location_map_params)
        format.html { redirect_to @location_map, notice: 'Location map was successfully updated.' }
        format.json { render :show, status: :ok, location: @location_map }
      else
        format.html { render :edit }
        format.json { render json: @location_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /location_maps/1
  # DELETE /location_maps/1.json
  def destroy
    @location_map.destroy
    respond_to do |format|
      format.html { redirect_to location_maps_url, notice: 'Location map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_map
      @location_map = LocationMap.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_map_params
      params.fetch(:location_map, {})
    end
end
