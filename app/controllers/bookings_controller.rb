class BookingsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_booking, only: [:show, :accept, :reject, :pay]

    def index
        #@bookings = Booking.order(:from_date, :created_at)
        @bookings = Booking.where(user_id: current_user.id).or(Booking.where(petsitter_id: current_user.petsitter))

    end

    def show
    end

    def edit
        @statuses = Booking.statuses
    end

    def new

        @booking = Booking.new
        @petsitter = Petsitter.find(params[:id].to_i)
        @booking.petsitter_id = @petsitter.id
        @pets = Pet.where(user_id: current_user.id)

    end

    def accept

        if @booking.status == Booking.statuses.keys[0] &&
           @booking.petsitter_id = current_user.petsitter.id

           @booking.status = Booking.statuses.keys[1]
           @booking.save
        end

        redirect_to booking_path(@booking.id)

    end

    def reject

        if ( @booking.status == Booking.statuses.keys[0] || 
             @booking.status == Booking.statuses.keys[1] ) &&
           ( @booking.user_id == current_user.id || 
             @booking.petsitter_id == current_user.petsitter.id
           )
           
            @booking.status = Booking.statuses.keys[2]
            @booking.save
         end

        redirect_to booking_path(@booking.id)

    end

    def pay

        if @booking.status == Booking.statuses.keys[1] &&
            @booking.user_id = current_user.id
 
            @booking.status = Booking.statuses.keys[3]
            @booking.save
         end

        redirect_to booking_path(@booking.id)

    end

    def create

        whitelisted_params = booking_params
        whitelisted_params.merge!(user_id: current_user.id)

        petsitter = Petsitter.find(params[:booking][:petsitter_id])
        total_amount = (params[:booking][:to_date].to_date - params[:booking][:from_date].to_date).to_i * petsitter.price_rate
       
        whitelisted_params.merge!(total_amount: total_amount)

        whitelisted_params.merge!(status: Booking.statuses.keys[0])
        
        @booking = current_user.bookings.create(whitelisted_params)

        if @booking.errors.any?
            render "new"
        else
            redirect_to booking_path(@booking)
        end
    end

    def destroy
        id = params[:id]
        #Booking.find(id).destroy
        booking = Booking.find(id)
        booking.status = Booking.statuses.keys[2]
        booking.save
        redirect_to bookings_path
    end

    private

    private

    def booking_params
        params.require(:booking).permit(:from_date, :to_date, :petsitter_id, pet_ids: [])
    end

    def set_booking
        @booking = Booking.find(params[:id])
    end

end