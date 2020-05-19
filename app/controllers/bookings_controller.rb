class BookingsController < ApplicationController
    before_action :require_user, only: [:new, :create]

    def home
        @bookings = Booking.all
    end

    def new
        @booking = Booking.new
    end

    def create
        require 'date'
        @booking = Booking.new(booking_params)
        @booking.table_no = 1
        @booking.end_time = @booking.start_time + @booking.duration.minutes
        @booking.user = current_user

        #check if booking with same date and same time
        between_start = @booking.start_time.strftime("%Y-%m-%d %T")
        between_end = @booking.end_time.strftime("%Y-%m-%d %T")
        @advance_booking = Booking.where("(start_time BETWEEN '#{between_start}' AND '#{between_end}') OR (end_time BETWEEN '#{between_start}' AND '#{between_end}')")
        #onehourcheckbyself
        @last_booking = Booking.where("user_id = #{@booking.user.id}").last
        timediff = ((Time.parse(@booking.start_time.to_s)-Time.parse(@last_booking.end_time.to_s))/60).to_i
        if timediff <= 60
            flash[:alert] = "Minimun interval of 1 hour between two bookings for the same user"
            render 'new'
        elsif !@advance_booking.empty?
            flash[:alert] = "There already exists a booking on same date and time"
            render 'new'
        elsif @booking.save
            flash[:notice] = "Booking was done successfully"
            redirect_to root_path
        else
            render 'new'
        end
    end

    private
    def booking_params
        params.require(:booking).permit(:start_time, :duration)
    end
end