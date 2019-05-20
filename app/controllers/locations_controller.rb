class LocationsController < ApplicationController
  before_action :set_location, only: %i(edit update show)

  def index
    @locations = current_user.locations
  end

  def show
    @location = Location.includes(:reviews, :rooms).find_by id: params[:id]
  end

  private
    def set_location
      @location = Location.find_by id: params[:id]
      return if @location
      flash[:error] = t(".location_not_found")
      redirect_to locations_path
    end

    def location_params
      params.require(:location).permit Location::LOCATION_PARAMS
    end
end
