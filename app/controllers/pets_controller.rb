class PetsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_pet, only: [:show, :edit, :update]

    def index
        # Retrieving only those pets which belong to the logged in user 
        @pets = current_user.pets
    end

    def show

    end

    def edit
        # Retrieving all the possible ENUMS for PET-TYPES
        @pet_types = Pet.pet_types
    end

    def new
        # Assigning @pet the "shape" of a pet active record (no values)
        @pet = Pet.new
        # Retrieving all the possible ENUMS for PET-TYPES
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

        # Saving into the database all the whitelisted values received by the View
        @pet = current_user.pets.create(whitelisted_params)

        if @pet.errors.any?
            @pet_types = Pet.pet_types
            render "new"
        else
            redirect_to pet_path(@pet)
        end
    end

    def destroy
        # Retrieving id from the view
        id = params[:id]

        # Deleting the specified PET record ID from the database
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