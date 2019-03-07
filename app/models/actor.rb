class Actor < ActiveRecord::Base
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  # def movie
  #   all_movies = []
  #   all_movie_ids = MovieActors.where(actor_id: self.id)
  #   all_movie_ids.each do |movie|
  #     all_movies << Movie.find_by(id: movie["movie_id"])
  #   end
  #   all_movies
  # end
end
