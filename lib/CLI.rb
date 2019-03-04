require 'rest-client'
require 'json'
require 'rainbow'

class CommandLine

  def greet
    puts Rainbow("
              ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗
              ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝
              ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗
              ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝
              ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗
               ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝
   ").red
  puts Rainbow("\n    Welcome to MovieFinder, the command line solution to for your Movie-finding needs!\n").white.bright
  end


  def gets_user_input
    puts Rainbow("\n    We can help you find which genre a movie is.
      \n    Enter a movie to get started:\n").white.bright
    # puts "We can help you find which genre a movie is."
    # puts "Enter a movie to get started:"
    find_movie = gets.chomp
  end

  def find_movie(name)
    Movie.find_by(title: name)
  end

  def run
    greet
    input = gets_user_input
    x = find_movie(input)
    puts Rainbow("🎬 " + x.title + " 🎬").red.bright
    puts Rainbow(x.review).white.bright
  end

  def find_actors(movie)
    movies.actors
  end

  def show_actors(actors)
    actors.each do |actor|
      find_actors
    end
  end
end
