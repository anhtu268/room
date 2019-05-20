class ReservationsController < ApplicationController
  before_action :load_reservations, only: %i(show)
  before_action :logged_in_user, only: :create
  def create
    @book_room = BookRoom.new(reservations_params, current_user).book
    if @book_room[:reservation].valid? && @book_room[:detail].valid?
      flash[:success] = "Book room success!"
      redirect_to request.referer
    else
      @reservation = @book_room[:reservation]
      @reservation_detail = @book_room[:detail]
      @location = Location.find_by id: params[:location_id]
      render :new
    end
  end

  def new
    @location = Location.find_by id: params[:location_id]
    @reservation = Reservation.new
    @reservation_detail = ReservationDetail.new
  end

  private
  def load_reservations
    @reservations = reservations.find_by id: params[:id]
    return if @reservations
    flash[:error] = t(".reservations_not_found")
    redirect_to reservationss_url
  end

  def reservations_params
    params.permit(room: {},location: [:id])
  end
end
