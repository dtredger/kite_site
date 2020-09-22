class KiteSpotsController < ApplicationController
  before_action :get_all_kite_spots, only: :index
	before_action :set_kite_spot, only: [:show, :edit, :update, :destroy]

  # GET /kite_spots
  # GET /kite_spots.json
  def index
  end

  # GET /kite_spots/1
  # GET /kite_spots/1.json
  def show
  end

  # GET /kite_spots/new
  def new
	  @kite_spot = KiteSpot.new
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
			  format.html { redirect_to @kite_spot, notice: 'Kite Spot was successfully created.' }
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
			  format.html { redirect_to @kite_spot, notice: 'Kite Spot was successfully updated.' }
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
		  format.html { redirect_to kite_spots_url, notice: 'Kite Spot was successfully destroyed.' }
		  format.json { head :no_content }
	  end
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
	  @kite_spot = KiteSpot.friendly.find(params[:id])
  end

  def kite_spot_params
	  params.fetch(:kite_spot, {}).permit(:name, :content)
  end

end
