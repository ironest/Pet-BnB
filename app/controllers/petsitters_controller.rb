class PetsittersController < ApplicationController

    before_action :authenticate_user!

    def index
        @petsitters = Petsitter.all
    end

    def show
    end

end