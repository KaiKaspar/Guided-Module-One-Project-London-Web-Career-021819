require_relative '../config/environment'


cli = CommandLine.new

# cli.run
cli.add_movie

require 'rest-client'
require 'json'
