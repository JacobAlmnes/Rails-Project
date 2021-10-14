class FavoritesController < ApplicationController

    before_action :require_signin
    def create
        @movie = Movie.find(params[:movie_id])       
        @movie.fans << current_user
      
        redirect_to @movie
      end

    def new
        
    end

    def index
        
    end

    def destroy
        favorite = current_user.favorites.find_by(params[:id])
        favorite.destroy

        movie = Movie.find_by(params[:movie_id])
        redirect_to movie 
    end
end
