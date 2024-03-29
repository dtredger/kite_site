# frozen_string_literal: true

class FavoritesController < ApplicationController
  load_and_authorize_resource

  def update
    return unless favorite_params[:model_name] && favorite_params[:id]

    model_class = ([favorite_params[:model_name]] & %w[KiteSpot Country]).first
    model = model_class.constantize.find(favorite_params[:id])
    return unless model

    if favorite_params[:status] == 'add'
      existing_favorites = current_user.favorites.where(favoritable_type: model_class)
      # TODO: handle all this in model
      # return if existing_favorites.map(&:favoritable_id).include?(favorite_params[:id])
      current_user.favorite(model)
    else
      current_user.unfavorite(model)
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:model_name, :id, :status)
  end
end
