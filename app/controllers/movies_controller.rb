class MoviesController < ApplicationController
  IMDB_URL = "http://www.imdb.com/find?s=all"
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  layout "application"
  def index
    if params[:search] && params[:search].present?
      @movies = Movie.where("title ILIKE ?",'%'+params[:search]+'%')
      if !@movies.present?
        url = "#{IMDB_URL}&q=#{params[:search]}"
        redirect_to url and return ;
      end
    else
      @movies = Movie.all
    end
  end

  def show
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")

    if @reviews.average(:rating).nil?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  def new
    @movie = current_user.movies.build
  end

  def edit
  end

  def my_movies
    @movies = Movie.all.where(user: current_user)
  end
  # POST /movies
  # POST /movies.json
  def create
    @movie = current_user.movies.build(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :description, :movie_length, :director, :rating, :image, :category)
    end
end
