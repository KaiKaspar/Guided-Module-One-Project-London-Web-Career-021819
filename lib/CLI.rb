require 'rest-client'
require 'json'
require 'rainbow'

require 'rest-client'
require 'json'

url = "http://www.omdbapi.com/?i=tt3896198&apikey=dc2f1dca"
response = RestClient.get(url)
response_hash = JSON.parse(response)


class CommandLine
  def json_url
    puts "Type Name...."
    name = gets.chomp
    search_name = name.sub(" ", "+")
    url = "http://www.omdbapi.com/?t=#{search_name}&apikey=dc2f1dca"
    response = RestClient.get(url)
    response_hash = JSON.parse(response)
  end

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

  def add_movie
    movie_hash = json_url
    # binding.pry
    Movie.create(title: movie_hash["Title"], genre: movie_hash["Genre"], release_date: movie_hash["Year"], plot: movie_hash["Plot"])
  end
  # def find_movie(name)
  #   Movie.find_by(title: name)
  # end

  def run
    greet
    input = gets_user_input
    x = find_movie(input)
    puts Rainbow("🎬 " + x.title + " 🎬").red.bright
    puts Rainbow(x.review).white.bright
  end

  def all_movies_with_actors
    @all = all_movies_with_actors
    @all.each do |title, actors|
      puts "#{title}; #{actors}"
    end
    @all
  end

  def find_movies_for_actor(actor)
    actor_movies = all_movies_with_actors.select do |title, name|
      name.split(", ") == actor
    end
  end

  def find_actors_for_movie(movie)
    movie_actors = find_actors_for_movie.select do |title, name|
      name.split(", ") == actor
    end
  end
end
