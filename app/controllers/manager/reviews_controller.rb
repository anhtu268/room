class Manager::ReviewsController < Manager::ApplicationController
  before_action :load_location
  def index
    @reviews = @location.reviews.includes(:user).page(params[:page]).per 10
  end

  private
  def load_location
    @location = Location.find_by id: params[:location_id]
    return if @location
    flash[:error] = t(".location_not_found")
    redirect_to manager_locations_path
  end
end
