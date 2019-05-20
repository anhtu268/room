class Manager::ReservationsController < Manager::ApplicationController
  before_action :load_location
  def index
    @reservations = Reservation.joins(:rooms).where(rooms: {location_id: @location.id}).group(:id).page(params[:page]).per 10
  end

  def search
    @reservations = SearchService.new(@location.reservations,search_params,Settings.search_fields.reservation).all_records
      .page(params[:page]).per 10
    render :index
  end

  def update
    @reservation = Reservation.find_by id: params[:id]
    @reservation.update status: 1
    redirect_to manager_location_reservations_path(@location)
  end

  private
  def load_location
    @location = Location.find_by id: params[:location_id]
    return if @location
    flash[:error] = t(".location_not_found")
    redirect_to manager_locations_path
  end
end
