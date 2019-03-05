require 'rest-client'
require 'json'
require 'rainbow'

require 'rest-client'
require 'json'

url = "http://www.omdbapi.com/?i=tt3896198&apikey=dc2f1dca"
response = RestClient.get(url)
response_hash = JSON.parse(response)


class CommandLine
  def json_url(name)
    # name = gets.chomp
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

  def menu
    puts Rainbow("    Please select an option by typing the corresponding number:\n
      1| Search a movie
      2| Search an actor
      3| Search a genre
      4| Search highest rated movies
      5| Test your movie knowledge!
      6| Quit").white.bright
  end

  def menu_choice
    user_input = gets.chomp
    case user_input
    when "1"
      run
    when "2"
        #Todo
      puts "Currently not availiable"
    when "3"
        #Todo
      puts "Currently not availiable"
    when "4"
        #Todo
      puts "Currently not availiable"
    when "5"
        #Todo
      puts "Currently not availiable"
    when "6"
        #Todo
      puts "Currently not availiable"
    else puts "Invalid please try again"
      menu
      menu_choice
    end
  end


  def gets_user_input
    puts Rainbow("\n    Search a movie to get a quick description:").white.bright
    # puts "We can help you find which genre a movie is."
    # puts "Enter a movie to get started:"
    find_movie = gets.chomp
  end
  #
  # def add_movie
  #   movie_hash = json_url(name)
  #   Movie.create(title: movie_hash["Title"], genre: movie_hash["Genre"], release_date: movie_hash["Year"], plot: movie_hash["Plot"], all_actors_names: movie_hash["Actors"])
  # end

  def find_or_create(input)
    movie_hash = json_url(input)
    Movie.find_or_create_by(title: movie_hash["Title"], genre: movie_hash["Genre"], release_date: movie_hash["Year"], plot: movie_hash["Plot"], all_actors_names: movie_hash["Actors"])
  end

  # def find_movie(name)
  #     Movie.find_by(title: name)
  # end

  def run
    input = gets_user_input
    x = find_or_create(input)
    # binding.pry
    puts Rainbow("   🎬 " + x.title + " 🎬").red.bright
    puts Rainbow(x.plot).white.bright
    # binding.pry
    puts Rainbow("GENRE: " + x.genre).white.bright
    puts Rainbow("Starring: " + x.all_actors_names).white.bright
  end

  # def all_movies_with_actors
  #   @all = all_movies_with_actors
  #   @all.each do |title, actors|
  #     puts "#{title}; #{actors}"
  #   end
  #   @all
  # end
  #
  # def find_movies_for_actor(actor)
  #   actor_movies = all_movies_with_actors.select do |title, name|
  #     name.split(", ") == actor
  #   end
  # end
  #
  # def find_actors_for_movie(movie)
  #   movie_actors = find_actors_for_movie.select do |title, name|
  #     name.split(", ") == actor
  #   end
  # end
end
