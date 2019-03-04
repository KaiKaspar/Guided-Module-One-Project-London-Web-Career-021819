class Movie < ActiveRecord::Base
  has_many :movie_actors
  has_many :actors, through: :movie_actors
end
