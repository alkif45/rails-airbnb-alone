class BookingsController < ApplicationController
  before_action :set_flat, only: %i[new create]

  def index
    @guest_bookings = current_user.guest_bookings.includes(:flat)
    @host_bookings = current_user.host_bookings.includes(:flat)
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @flat = @booking.flat
    @booking.guest = current_user
    if @booking.save
      redirect_to @booking, notice: "Booking successfully made"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :number_of_guests)
  end

  def set_flat
    @flat = Flat.find(params[:flat_id])
  end
end
