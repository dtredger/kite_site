# frozen_string_literal: true

class CountriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  before_action :set_country, only: %i[show edit update destroy]

  def index
    @countries = Country.all.includes([:photos_attachments])
  end

  def show; end

  def new
    @country = Country.new
  end

  def edit; end

  def create
    @country = Country.new(country_params)

    if @country.save
      redirect_to @country, notice: 'Country was successfully created.'
    else
      render :new
    end
  end

  def update
    if @country.update(country_params)
      redirect_to @country, notice: 'Country was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @country.destroy
    redirect_to countries_url, notice: 'Country was successfully deleted.'
  end

  private

  def set_country
    @country = Country.friendly.find(params[:id])
  end

  def country_params
    params.fetch(:country, {}).permit(:name, :latitude, :longitude, :region)
  end
end

# permit images: []
