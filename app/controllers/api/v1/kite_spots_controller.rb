# frozen_string_literal: true

module Api
  module V1
    class KiteSpotsController < Api::BaseController
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
        params[:page][:number] if params[:page]
      end
    end
  end
end
