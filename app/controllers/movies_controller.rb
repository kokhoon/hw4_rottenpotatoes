class MoviesController < ApplicationController

  def show
#puts "MoviesController#show params[:id] = #{params[:id]}"
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    if @movie.director and @movie.director.length > 0
#puts "show: @movie[:director] = #{@movie[:director]}"
#      @link_similar = movies_path + '/director/' + ERB::Util::url_encode( @movie[:director] ) 
      @link_similar = movie_path + '/director/'  
    else
      @link_similar = movie_path + '/director/'
    end
  end

  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:order => :title}, 'hilite'
    when 'release_date'
      ordering,@date_header = {:order => :release_date}, 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}

    if params[:sort] != session[:sort]
      session[:sort] = sort
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end

    if params[:ratings] != session[:ratings] and @selected_ratings != {}
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end
    @movies = Movie.find_all_by_rating(@selected_ratings.keys, ordering)
  end

  def director
#puts "MoviesController#director: params[:director]:#{params[:director]} params[:id]:#{params[:id]}"
    if params[:id]
      base_movie = Movie.find(params[:id])
      if base_movie 
        if base_movie.director and base_movie.director.length > 0
          @movies = base_movie.same_director
        else
#puts "'#{base_movie.title}' has no director info"
          flash[:notice] = "'#{base_movie.title}' has no director info"
          redirect_to '/'
        end
      else
        #invalid movie-id, redirect to /movies
        redirect_to movies_path
      end
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
 
