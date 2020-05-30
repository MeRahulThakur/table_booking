class BookingsController < ApplicationController
    before_action :require_user, only: [:new, :create]

    def home
        @bookings = Booking.all
    end

    def new
        @booking = Booking.new
    end

    def create
        @booking = Booking.new(booking_params)
        @booking.user = current_user
        if @booking.save
            flash[:notice] = "Booking was done successfully"
            redirect_to root_path
        else
            render 'new'
        end
    end

    private
    def booking_params
        params.require(:booking).permit(:table_no, :start_time, :duration)
    end
end
