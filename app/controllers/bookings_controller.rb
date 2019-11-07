class BookingsController < ApplicationController

    skip_before_action :verify_authenticity_token, only: [:webhook]
    before_action :authenticate_user!
    before_action :set_booking, only: [:show, :accept, :reject, :success]

    def index
        @bookings = Booking.where(user_id: current_user.id).or(Booking.where(petsitter_id: current_user.petsitter))
    end

    def show

        session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: [{
                name: "Pet-BnB booking",
                description: "#{@booking.petsitter.user.first_name} #{@booking.petsitter.user.last_name}' services",
                images: [url_for(@booking.petsitter.user.picture)],
                amount: @booking.total_amount,
                currency: 'aud',
                quantity: 1,
            }],
            payment_intent_data: {
                metadata: {
                    user_id: current_user.id,
                    booking_id: @booking.id,
                    petsitter_id: @booking.petsitter_id,
                    total_amount: @booking.total_amount
                }
            },
            success_url: "#{root_url}bookings/#{@booking.id}/success",
            cancel_url: "#{root_url}bookings"
        )

        @session_id = session.id

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

    def webhook
        puts params

        payment_id = params[:data][:object][:payment_intent]
        payment = Stripe::PaymentIntent.retrieve(payment_id)

        booking_id = payment.metadata.booking_id
        petsitter_id = payment.metadata.booking_id
        user_id = payment.metadata.user_id
        total_amount = payment.metadata.total_amount

        status 200

        booking = Booking.find_by_id(booking_id).where(petsitter_id:petsitter_id, )

    end

    def success

        # if @booking.status == Booking.statuses.keys[1] &&
        #     @booking.user_id = current_user.id
 
        #     @booking.status = Booking.statuses.keys[3]
        #     @booking.save
        #  end

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

    private

    private

    def booking_params
        params.require(:booking).permit(:from_date, :to_date, :petsitter_id, pet_ids: [])
    end

    def set_booking
        @booking = Booking.find(params[:id])
    end

end