class MoviesController < ApplicationController
    def index
        @movies = ["Rion man", "Spiderman", "Superman", "Interstellar"]
    end
end
