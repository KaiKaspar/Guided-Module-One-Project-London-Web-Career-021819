require_relative '../config/environment'


cli = CommandLine.new


cli.greet
cli.menu
cli.menu_choice
# cli.all_movies_for_actor
# cli.all_actors_for_movie
# cli.all_actor_ratings
# cli.top_10_actors

require 'rest-client'
require 'json'
