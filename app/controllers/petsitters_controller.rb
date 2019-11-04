class PetsittersController < ApplicationController

    before_action :authenticate_user!
    before_action :set_petsitter, only: [:show, :edit, :update]

    def index
        @petsitters = Petsitter.all
    end

    def show

    end

    def edit

    end

    def new

        if current_user.petsitter.nil?
            @petsitter = Petsitter.new
            # Assigning the user_id is just to allow showing the user picture in the "new" html page
            @petsitter.user_id = current_user.id
        else
            #render "edit"
            redirect_to petsitter_path(current_user.petsitter)
        end

    end

    def update

        whitelisted_params = petsitter_params

        if @petsitter.update(whitelisted_params)
            redirect_to petsitter_path(params[:id])
        else
            render "edit"
        end

    end

    def create
        whitelisted_params = petsitter_params
        @petsitter = current_user.create_petsitter(whitelisted_params)

        if @petsitter.errors.any?
            render "new"
        else
            redirect_to petsitter_path(@petsitter)
        end
    end

    def destroy
        id = params[:id]
        Petsitter.find(id).destroy
        redirect_to petsitters_path
    end

    private

    def petsitter_params
        params[:petsitter][:status] = params[:petsitter][:status].to_i
        params.require(:petsitter).permit(:price_rate, :status)
    end

    def set_petsitter
        @petsitter = Petsitter.find(params[:id])
    end

end