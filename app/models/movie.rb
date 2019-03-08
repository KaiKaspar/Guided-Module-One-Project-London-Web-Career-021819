class Movie < ActiveRecord::Base
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  def create_movie(genre, release_date, all_actors_names)
    Movie.new(self, genre, release_date, all_actors_names)
  end

end
