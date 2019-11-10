class BookingsController < ApplicationController

    protect_from_forgery except: [:webhook]
    before_action :authenticate_user!, except: [:webhook]
    before_action :set_booking, only: [:show, :accept, :reject, :success]

    def index
        # Retrieving from the Database all the bookings involving to the logged-in user.
        # The logged in user can either be the pet-owner (first where condition) or the pet-sitter (second where condition)
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

    def new

        # Assigning @booking the "shape" of the Booking active record. No real data is retrieved 
        @booking = Booking.new
        # Assigning @petsitter with the specific Petsitter record ID 
        @petsitter = Petsitter.find(params[:id].to_i)
        # Manually populating foreign keys
        @booking.petsitter_id = @petsitter.id
        # Retrieving an array of Pets Active Records
        @pets = Pet.where(user_id: current_user.id)

    end

    def accept

        # Validating input requests; an accepted booking can only be processed if the status of the booking was pending
        if @booking.status == Booking.statuses.keys[0] &&
           @booking.petsitter_id = current_user.petsitter.id

           # Processing the booking with the next status code
           @booking.status = Booking.statuses.keys[1]

           # Applying/Updating the new status code to the database
           @booking.save
        end

        redirect_to booking_path(@booking.id)

    end

    def reject

        # Validating input requests; a rejection on a booking can only be processed if the status of the booking was either pending or waiting for payment
        if ( @booking.status == Booking.statuses.keys[0] || 
             @booking.status == Booking.statuses.keys[1] ) &&
           ( @booking.user_id == current_user.id || 
             @booking.petsitter_id == current_user.petsitter.id
           )
           
            # Processing the booking with the next status code
            @booking.status = Booking.statuses.keys[2]

            # Applying/Updating the new status code to the database
            @booking.save
         end

        redirect_to booking_path(@booking.id)

    end

    def webhook

        head 200

        stripe_id = params[:data][:object][:payment_intent]
        payment = Stripe::PaymentIntent.retrieve(stripe_id)

        booking_id = payment.metadata.booking_id
        petsitter_id = payment.metadata.petsitter_id
        user_id = payment.metadata.user_id
        total_amount = payment.metadata.total_amount

        # Retrieving from the database the exact record corresponding to the booking received by Stripe
        booking = Booking.find_by_id(booking_id)

        # Checking if an active record was found
        if booking
            puts "WEBHOOK: A booking record with id=#{booking_id} was found!"

            if booking.petsitter_id.to_s == petsitter_id.to_s &&
               booking.user_id.to_s == user_id.to_s &&
               booking.total_amount.to_s == total_amount.to_s

                puts "WEBHOOK: All attributes match!"

                # Marking the active record as Completed
                booking.status = Booking.statuses.keys[3]
                booking.stripe_id = stripe_id

                # Updating the database
                booking.save

            else
                puts "WEBHOOK: ERROR, Attributes do not match!"

                p petsitter_id
                p user_id
                p total_amount

                p booking.petsitter_id
                p booking.user_id
                p booking.total_amount

            end
        else
            puts "WEBHOOK: ERROR, No booking record found!"

        end

    end

    def success

        redirect_to booking_path(@booking.id)

    end

    def create

        whitelisted_params = booking_params
        whitelisted_params.merge!(user_id: current_user.id)

        # Retrieving the Petsitter record involved with the request (received by the View)
        petsitter = Petsitter.find(params[:booking][:petsitter_id])
        total_amount = (params[:booking][:to_date].to_date - params[:booking][:from_date].to_date).to_i * petsitter.price_rate
       
        # Adding extra field to the whitelisted fields
        whitelisted_params.merge!(total_amount: total_amount)

        # Adding extra field to the whitelisted fields
        whitelisted_params.merge!(status: Booking.statuses.keys[0])
        
        # Saving/applying the new record on the Bookings table
        # By using "current_user" as first element, I get for free all the FK required
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
        # Retrieving from the Database the required Booking ID (passed by the View)
        @booking = Booking.find(params[:id])
    end

end