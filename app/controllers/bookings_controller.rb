class BookingsController < ApplicationController

    before_action :authenticate_user!

    def index
        @bookings = Booking.all
    end

    def show
    end

end