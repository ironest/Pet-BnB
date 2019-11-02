class PetsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_pet, only: [:show, :edit, :update]

    def index
        @pets = Pet.all
    end

    def show

    end

    def edit
        @pet_types = Pet.pet_types
    end

    def new
        @pet = Pet.new
        @pet_types = Pet.pet_types
    end

    def update

        whitelisted_params = pet_params

        if @pet.update(whitelisted_params)
            redirect_to pet_path(params[:id])
        else
            render "edit"
        end

    end

    def create
        whitelisted_params = pet_params
        @pet = current_user.pets.create(whitelisted_params)

        if @pet.errors.any?
            @pet_types = Pet.pet_types
            render "new"
        else
            redirect_to pet_path(@pet)
        end
    end

    def destroy
        id = params[:id]
        Pet.find(id).destroy
        redirect_to pets_path
    end

    private

    def pet_params
        params[:pet][:pet_type] = params[:pet][:pet_type].to_i
        params.require(:pet).permit(:name, :pet_type, :picture)
    end

    def set_pet
        @pet = Pet.find(params[:id])
    end

end