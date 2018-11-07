class MoviesController < ApplicationController

  def index
    @movies = Movie.all

    render status: :ok
  end

  def show
    @movie = Movie.find_by(id: params[:id])

    if @movie
      render status: :ok
    else
      render_error(:not_found, { movie_id: ["Movie not found"]})
    end
  end

  def create

    @movie = Movie.new(movie_params)

    if @movie.save
      render json: { id: @movie.id }
      # render status: :ok
    else
      render_error(:bad_request, movie.errors.messages)
    end
  end

  private

  def movie_params
    params.permit(:title, :inventory, :overview, :release_date)
  end

end
