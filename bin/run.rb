require_relative '../config/environment'


cli = CommandLine.new


# cli.greet
# cli.menu
# cli.menu_choice
cli.find_all_movies_for_actor


require 'rest-client'
require 'json'
