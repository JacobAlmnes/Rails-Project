class MoviesController < ApplicationController

    before_action :require_signin, except: [:index, :show]
    before_action :require_admin, except:[:index, :show]



    def index
        case params[:filter]
        when "upcoming"
            @movies = Movie.upcoming
        when "recent"
            @movies = Movie.recent

        when "hits"
            @movies = Movie.hits
        when "flops"
            @movies = Movie.flops
        else
            @movies = Movie.released
        end
    end


    def show
        @movie = Movie.find(params[:id])
        @genres = @movie.genres
        if current_user
            @favorite = current_user.favorites.find_by(movie_id: @movie.id)
        end
    end

    def edit
        @movie = Movie.find(params[:id])
        @genres = @movie.genres
    end

    def update
        @movie = Movie.find(params[:id])

        if @movie.update(movies_params)
            redirect_to @movie, notice: "Movie successfully updated!"
        else
            render :edit
        end
    end
    def new
        @movie =Movie.new
    end

    def create
        @movie = Movie.new(movies_params)
        if @movie.save
          redirect_to @movie, notice: "Movie successfully created!"
        else
          render :new
        end
    end

end
private 
    def movies_params
        params.require(:movie).
            permit(:title, :description, :rating, :released_on, :total_gross,
                    :director, :duration, :image_file_name, genre_ids:  [])
    end

