class BookingsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_booking, only: [:show, :edit, :update]

    def index
        @bookings = Booking.all
    end

    def show
    end

    def edit
        @statuses = Booking.statuses
    end

    def new
        @booking = Booking.new
        @statuses = Booking.statuses
    end

    def update

        whitelisted_params = Booking_params

        if @booking.update(whitelisted_params)
            redirect_to Booking_path(params[:id])
        else
            render "edit"
        end

    end

    def create
        whitelisted_params = Booking_params
        @booking = current_user.Bookings.create(whitelisted_params)

        if @booking.errors.any?
            @statuses = Booking.statuses
            render "new"
        else
            redirect_to Booking_path(@booking)
        end
    end

    def destroy
        id = params[:id]
        Booking.find(id).destroy
        redirect_to Bookings_path
    end

    private

    def booking_params
        params[:Booking][:Booking_type] = params[:Booking][:Booking_type].to_i
        params.require(:Booking).permit(:name, :Booking_type, :picture)
    end

    def set_booking
        @booking = Booking.find(params[:id])
    end

end