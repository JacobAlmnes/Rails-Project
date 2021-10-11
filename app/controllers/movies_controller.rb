class MoviesController < ApplicationController
    def index
        @movies = Movie.released
    end
    def show
        @movie = Movie.find(params[:id])
    end

    def edit
        @movie = Movie.find(params[:id])
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

    def destroy
        @movie = Movie.find(params[:id])
        movietitle = @movie.title
        if @movie.destroy
            redirect_to movies_url, alert: "Deleted #{movietitle}"
        end
    end

end
private 
    def movies_params
        params.require(:movie).
            permit(:title, :description, :rating, :released_on, :total_gross,
                    :director, :duration, :image_file_name)
    end

