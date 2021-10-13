class ReviewsController < ApplicationController

    before_action :current_movie
    before_action :require_signin, only:[:create, :new, :destroy]
    def index
        @movie =current_movie
        @reviews = @movie.reviews
    end
    
    def new
        @movie = current_movie
        @review = @movie.reviews.new()        
    end

    def create
        @movie = current_movie
        @review = @movie.reviews.new(review_params)
        @review.user = current_user
        

        if @review.save
            redirect_to movie_reviews_url(@movie), notice: "Thanks for you review"
        else
            render :new
        end
    end

    def destroy
        @movie =  current_movie
        @review = get_review
        @review.destroy
        redirect_to movie_reviews_path(get_review), alert: "Deleted review"
        
    end
end


private 
    def review_params
        params.require(:review).
            permit(:comment, :stars)
    end

    def get_review
        @review = Review.find_by(id: params[:id])
    end 

    

    def current_movie
        @movie = Movie.find(params[:movie_id])
    end

