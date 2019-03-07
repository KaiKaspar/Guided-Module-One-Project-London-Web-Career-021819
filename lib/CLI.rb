require 'rest-client'
require 'json'
require 'rainbow'


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

  def return_to_menu
    puts Rainbow("Would you like to return to the menu? type 'y' for yes or 'n' for no.").white.bright
    answer = gets.chomp
          # binding.pry
    if answer.downcase == "y"
      menu
      menu_choice
    else
      # binding.pry
      abort
    end
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
      2| Search movies for a actor
      3| Test your movie knowledge!
      4| Quit").white.bright
  end

  def menu_choice
    user_input = gets.chomp
    case user_input
    when "1"
      run_movie
    when "2"
      all_movies_for_actor
    when "3"
      quiz_genre
    when "4"
        abort
    else puts "Invalid please try again"
      return_to_menu
    end
  end


  def gets_user_input
    puts Rainbow("\n    Search:").white.bright
    find_movie = gets.chomp
  end


  def find_or_create(input)
    movie_hash = json_url(input)
    movie = Movie.find_or_create_by(title: movie_hash["Title"], genre: movie_hash["Genre"], release_date: movie_hash["Year"], plot: movie_hash["Plot"], all_actors_names: movie_hash["Actors"])
    movie_hash["Actors"].split(", ").each do |actor|
      actor = Actor.find_or_create_by(name: actor)
      MovieActor.create(movie_id: movie.id, actor_id: actor.id)
    end
    puts Rainbow("   🎬 " + movie.title + " 🎬").red.bright
    puts Rainbow("GENRE: " + movie.genre).cyan.bright
    puts Rainbow(movie.plot).white.bright
    puts Rainbow("Starring: " + movie.all_actors_names).magenta.bright
  end

def all_movies_for_actor
  puts Rainbow("\n    Search:").white.bright
  input = gets.chomp

   af1 = Actor.find_by(name: input)
   af1.movies
   af1.movies.each do |movie|
     puts Rainbow("   🎬 " + movie.title + " 🎬").red.bright
     puts Rainbow("GENRE: " + movie.genre).cyan.bright
     puts Rainbow(movie.plot).white.bright
  end
  return_to_menu
end

# def all_movies_for_actor
#   puts Rainbow("\n    Search:").white.bright
#   self.movie
# end


  # def find_all_movies_for_actor
  #   input = gets_user_input
  #   movie_hash = json_url(input)
  #   movie = Movie.find_or_create_by(title: movie_hash["Title"], genre: movie_hash["Genre"], release_date: movie_hash["Year"], plot: movie_hash["Plot"], all_actors_names: movie_hash["Actors"])
  #   movie_hash["Actors"].split(", ").each do |actor|
  #     actor = Actor.find_or_create_by(name: actor)
  #     MovieActors.create(movie_id: movie.id, actor_id: actor.id)
  #   binding.pry
  #   end
  # end


  def run_movie
    input = gets_user_input
    find_or_create(input)
    return_to_menu
  end



  def quiz_genre
    puts Rainbow("    Test your knowledge and choose a catagory or if your feeling brave try out ultimate quiz!
          Please select an option by typing the corresponding number:").red.bright
    puts Rainbow("
      1| Horror 🧟
      2| Comedy 🤣
      3| Action 🚓
      4| Sci-Fi 🦸‍
      5| Drama 😱
      6| Animation 🧞
      7| All 🎥
      8| Quit").white.bright
      user_input = gets.chomp
      case user_input
      when "1"
        horror_quiz
      when "2"
        comedy_quiz
      when "3"
        action_quiz
      when "4"
        sci_fi_quiz
      when "5"
        drama_quiz
      when "6"
        animation_quiz
      when "7"
        all_quiz
      when "8"
        menu
        menu_choice
      else puts "Invalid please try again"
        quiz_genre
      end
  end

  def horror_quiz
    puts Rainbow("
 ██░ ██  ▒█████   ██▀███   ██▀███   ▒█████   ██▀███
▓██░ ██▒▒██▒  ██▒▓██ ▒ ██▒▓██ ▒ ██▒▒██▒  ██▒▓██ ▒ ██▒
▒██▀▀██░▒██░  ██▒▓██ ░▄█ ▒▓██ ░▄█ ▒▒██░  ██▒▓██ ░▄█ ▒
░▓█ ░██ ▒██   ██░▒██▀▀█▄  ▒██▀▀█▄  ▒██   ██░▒██▀▀█▄
░▓█▒░██▓░ ████▓▒░░██▓ ▒██▒░██▓ ▒██▒░ ████▓▒░░██▓ ▒██▒
▒ ░░▒░▒░ ▒░▒░▒░ ░ ▒▓ ░▒▓░░ ▒▓ ░▒▓░░ ▒░▒░▒░ ░ ▒▓ ░▒▓░
▒ ░▒░ ░  ░ ▒ ▒░   ░▒ ░ ▒░  ░▒ ░ ▒░  ░ ▒ ▒░   ░▒ ░ ▒░
░  ░░ ░░ ░ ░ ▒    ░░   ░   ░░   ░ ░ ░ ░ ▒    ░░   ░
░  ░  ░    ░ ░     ░        ░         ░ ░     ░
                                                    ").red.bright
    counter = 0
    puts Rainbow("What movie is the character Norman Bates in?").white.bright
    user_input = gets.chomp
    if user_input.downcase == "psycho"
      puts Rainbow("Correct").green.bright
      counter += 1
    else
      puts Rainbow("Wrong").red.bright
    end
    puts Rainbow("What movie does a burned madman come from the grave to kill with long sharp 'claws'?").white.bright
    user_input = gets.chomp
    if user_input.downcase == "a nightmare on elm street"
      puts Rainbow("Correct").green.bright
      counter += 1
    else
      puts Rainbow("Wrong").red.bright
    end
    puts Rainbow("What sense must you live without in Bird Box").white.bright
    user_input = gets.chomp
    if user_input.downcase == "sight"
      puts Rainbow("Correct").green.bright
      counter += 1
    else
      puts Rainbow("Wrong").red.bright
    end
    puts Rainbow("Who plays the lead role in Get Out?").white.bright
    user_input = gets.chomp
    if user_input.downcase == "daniel kaluuya"
      puts Rainbow("Correct").green.bright
      counter += 1
    else
      puts Rainbow("Wrong").red.bright
    end
    puts Rainbow("What film features 'redrum'?".reverse).white.bright
    user_input = gets.chomp
    if user_input.downcase == "the shining".reverse
      puts Rainbow("Correct").green.bright
      counter += 1
    else
      puts Rainbow("Wrong").red.bright
    end
    if counter == 5
    puts Rainbow("You need to get out more! You scored #{counter}/5").green.bright
  elsif counter > 2 && counter < 5
    puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
  else
    puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright

  end
  return_to_menu
  end

  def action_quiz
    puts Rainbow("
      ▄████████  ▄████████     ███      ▄█   ▄██████▄  ███▄▄▄▄
     ███    ███ ███    ███ ▀█████████▄ ███  ███    ███ ███▀▀▀██▄
     ███    ███ ███    █▀     ▀███▀▀██ ███▌ ███    ███ ███   ███
     ███    ███ ███            ███   ▀ ███▌ ███    ███ ███   ███
   ▀███████████ ███            ███     ███▌ ███    ███ ███   ███
     ███    ███ ███    █▄      ███     ███  ███    ███ ███   ███
     ███    ███ ███    ███     ███     ███  ███    ███ ███   ███
     ███    █▀  ████████▀     ▄████▀   █▀    ▀██████▀   ▀█   █▀
                                                                 ").orange.bright
                                                                 counter = 0
                                                                 puts Rainbow("Who directed the movies 'Jaws', 'Schindler's List' and 'Jurassic Park'?").white.bright
                                                                 user_input = gets.chomp
                                                                 if user_input.downcase == "stephen spielberg"
                                                                   puts Rainbow("Correct").green.bright
                                                                   counter += 1
                                                                 else
                                                                   puts Rainbow("Wrong").red.bright
                                                                 end
                                                                 puts Rainbow("Which films are about the Corleone family?").white.bright
                                                                 user_input = gets.chomp
                                                                 if user_input.downcase == "the godfather"
                                                                   puts Rainbow("Correct").green.bright
                                                                   counter += 1
                                                                 else
                                                                   puts Rainbow("Wrong").red.bright
                                                                 end
                                                                 puts Rainbow("Who plays the cop battling with terrorists in 'Die Hard'?").white.bright
                                                                 user_input = gets.chomp
                                                                 if user_input.downcase == "bruce willis"
                                                                   puts Rainbow("Correct").green.bright
                                                                   counter += 1
                                                                 else
                                                                   puts Rainbow("Wrong").red.bright
                                                                 end
                                                                 puts Rainbow("Which 1970s film about a giant animal was a remake of a 1933 movie?").white.bright
                                                                 user_input = gets.chomp
                                                                 if user_input.downcase == "king kong"
                                                                   puts Rainbow("Correct").green.bright
                                                                   counter += 1
                                                                 else
                                                                   puts Rainbow("Wrong").red.bright
                                                                 end
                                                                 puts Rainbow("'I will find you and I will kill you'").white.bright
                                                                 user_input = gets.chomp
                                                                 if user_input.downcase == "good luck"
                                                                   puts Rainbow("Correct").green.bright
                                                                   counter += 1
                                                                 else
                                                                   puts Rainbow("Wrong").red.bright
                                                                 end
                                                                 if counter == 5
                                                                 puts Rainbow("You need to get out more! You scored #{counter}/5").green.bright
                                                               elsif counter > 2 && counter < 5
                                                                 puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
                                                               else
                                                                 puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
                                                               end
                                                               return_to_menu
  end
  def sci_fi_quiz
    puts Rainbow("
      ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄          ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄
     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌        ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
     ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀  ▀▀▀▀█░█▀▀▀▀         ▐░█▀▀▀▀▀▀▀▀▀  ▀▀▀▀█░█▀▀▀▀
     ▐░▌          ▐░▌               ▐░▌             ▐░▌               ▐░▌
     ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌               ▐░▌ ▄▄▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄      ▐░▌
     ▐░░░░░░░░░░░▌▐░▌               ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ▐░▌
      ▀▀▀▀▀▀▀▀▀█░▌▐░▌               ▐░▌ ▀▀▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀      ▐░▌
               ▐░▌▐░▌               ▐░▌             ▐░▌               ▐░▌
      ▄▄▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄  ▄▄▄▄█░█▄▄▄▄         ▐░▌           ▄▄▄▄█░█▄▄▄▄
     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌        ▐░▌          ▐░░░░░░░░░░░▌
      ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀          ▀            ▀▀▀▀▀▀▀▀▀▀▀
                                                                              ").blue.bright
                                                                              counter = 0
                                                                              puts Rainbow("Who can snap their fingers and destroy half of humanity?").white.bright
                                                                              user_input = gets.chomp
                                                                              if user_input.downcase == "thanos"
                                                                                puts Rainbow("Correct").green.bright
                                                                                counter += 1
                                                                              else
                                                                                puts Rainbow("Wrong").red.bright
                                                                              end
                                                                              puts Rainbow("Who played Bane in Dark Night Rises?").white.bright
                                                                              user_input = gets.chomp
                                                                              if user_input.downcase == "tom hardy"
                                                                                puts Rainbow("Correct").green.bright
                                                                                counter += 1
                                                                              else
                                                                                puts Rainbow("Wrong").red.bright
                                                                              end
                                                                              puts Rainbow("What film features Keanu Reeves in a long leather black jacket").white.bright
                                                                              user_input = gets.chomp
                                                                              if user_input.downcase == "the matrix"
                                                                                puts Rainbow("Correct").green.bright
                                                                                counter += 1
                                                                              else
                                                                                puts Rainbow("Wrong").red.bright
                                                                              end
                                                                              puts Rainbow("What former governor was famous for saying 'I'll be back'?").white.bright
                                                                              user_input = gets.chomp
                                                                              if user_input.downcase == "arnold schwarzenegger"
                                                                                puts Rainbow("Correct").green.bright
                                                                                counter += 1
                                                                              else
                                                                                puts Rainbow("Wrong").red.bright
                                                                              end
                                                                              puts Rainbow("If you ever came across a galaxy guarding tree and asked for help what would they say?").white.bright
                                                                              user_input = gets.chomp
                                                                              if user_input.downcase == "i am groot"
                                                                                puts Rainbow("Correct").green.bright
                                                                                counter += 1
                                                                              else
                                                                                puts Rainbow("Wrong").red.bright
                                                                              end
                                                                              if counter == 5
                                                                              puts Rainbow("You need to get out more! You scored #{counter}/5").green.bright
                                                                            elsif counter > 2 && counter < 5
                                                                              puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
                                                                            else
                                                                              puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
                                                                            end
                                                                            return_to_menu
  end
  def comedy_quiz
    puts Rainbow("
      C)ccc                                  d)
     C)   cc                                 d)
    C)        o)OOO   m)MM MMM  e)EEEEE  d)DDDD y)   YY
    C)       o)   OO m)  MM  MM e)EEEE  d)   DD y)   YY
     C)   cc o)   OO m)  MM  MM e)      d)   DD y)   YY
      C)ccc   o)OOO  m)      MM  e)EEEE  d)DDDD  y)YYYY
                                                     y)
                                                y)YYYY  ").orange.bright
                                                counter = 0
                                                puts Rainbow("In what movie does the Stay Puft Marshmallow Man begin destroying New York City?").white.bright
                                                user_input = gets.chomp
                                                if user_input.downcase == "ghostbusters"
                                                  puts Rainbow("Correct").green.bright
                                                  counter += 1
                                                else
                                                  puts Rainbow("Wrong").red.bright
                                                end
                                                puts Rainbow("What is Napoleon Dynamite’s favorite sport?").white.bright
                                                user_input = gets.chomp
                                                if user_input.downcase == "tetherball"
                                                  puts Rainbow("Correct").green.bright
                                                  counter += 1
                                                else
                                                  puts Rainbow("Wrong").red.bright
                                                end
                                                puts Rainbow("In “Wedding Crashers,” what does Will Ferrell’s character crash?").white.bright
                                                user_input = gets.chomp
                                                if user_input.downcase == "funerals"
                                                  puts Rainbow("Correct").green.bright
                                                  counter += 1
                                                else
                                                  puts Rainbow("Wrong").red.bright
                                                end
                                                puts Rainbow("What nationality is Borat").white.bright
                                                user_input = gets.chomp
                                                if user_input.downcase == "kazakhstan"
                                                  puts Rainbow("Correct").green.bright
                                                  counter += 1
                                                else
                                                  puts Rainbow("Wrong").red.bright
                                                end
                                                puts Rainbow("Breaking News! street fight gets out of hand we go live to Ron Burgundy for his take?").white.bright
                                                user_input = gets.chomp
                                                if user_input.downcase == "well that escalated quickly"
                                                  puts Rainbow("Correct").green.bright
                                                  counter += 1
                                                else
                                                  puts Rainbow("Wrong").red.bright
                                                end
                                                if counter == 5
                                                puts Rainbow("You need to get out more! You scored #{counter}/5").green.bright
                                              elsif counter > 2 && counter < 5
                                                puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
                                              else
                                                puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
                                              end
                                              return_to_menu
  end

  def all_quiz
    puts Rainbow("
      █████╗ ██╗     ██╗
     ██╔══██╗██║     ██║
     ███████║██║     ██║
     ██╔══██║██║     ██║
     ██║  ██║███████╗███████╗
     ╚═╝  ╚═╝╚══════╝╚══════╝").gold.bright
     counter = 0
     puts Rainbow("How many dream levels do they get to in Inception?").white.bright
     user_input = gets.chomp
     if user_input.downcase == "5"
       puts Rainbow("Correct").green.bright
       counter += 1
     else
       puts Rainbow("Wrong").red.bright
     end
     puts Rainbow("How many James Bond movies are there?").white.bright
     user_input = gets.chomp
     if user_input.downcase == "26"
       puts Rainbow("Correct").green.bright
       counter += 1
     else
       puts Rainbow("Wrong").red.bright
     end
     puts Rainbow("What is the name of the hobbit played by Elijah Wood in the Lord of the Rings movies").white.bright
     user_input = gets.chomp
     if user_input.downcase == "frodo baggins"
       puts Rainbow("Correct").green.bright
       counter += 1
     else
       puts Rainbow("Wrong").red.bright
     end
     puts Rainbow("Which 1997 science fiction movie tells the story of a secret agency that polices alien refugees who are living on earth disguised as humans").white.bright
     user_input = gets.chomp
     if user_input.downcase == "men in black"
       puts Rainbow("Correct").green.bright
       counter += 1
     else
       puts Rainbow("Wrong").red.bright
     end
     puts Rainbow("Which Tom Hanks movie won the Academy Award for Best Picture in 1994?").white.bright
     user_input = gets.chomp
     if user_input.downcase == "forrest gump"
       puts Rainbow("Correct").green.bright
       counter += 1
     else
       puts Rainbow("Wrong").red.bright
     end
     if counter == 5
     puts Rainbow("You need to get out more! You scored #{counter}/5").green.bright
   elsif counter > 2 && counter < 5
     puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
   else
     puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
   end
   return_to_menu
  end
  def drama_quiz
    puts Rainbow("
      ########  ########     ###    ##     ##    ###
      ##     ## ##     ##   ## ##   ###   ###   ## ##
      ##     ## ##     ##  ##   ##  #### ####  ##   ##
      ##     ## ########  ##     ## ## ### ## ##     ##
      ##     ## ##   ##   ######### ##     ## #########
      ##     ## ##    ##  ##     ## ##     ## ##     ##
      ########  ##     ## ##     ## ##     ## ##     ## ").cyan.bright
      counter = 0
      puts Rainbow("
In which city was the film 'The Elephant Man' set?").white.bright
      user_input = gets.chomp
      if user_input.downcase == "london"
        puts Rainbow("Correct").green.bright
        counter += 1
      else
        puts Rainbow("Wrong").red.bright
      end
      puts Rainbow("What movie did Leonardo DiCaprio win a long awaited Oscar for?").white.bright
      user_input = gets.chomp
      if user_input.downcase == "the revenant"
        puts Rainbow("Correct").green.bright
        counter += 1
      else
        puts Rainbow("Wrong").red.bright
      end
      puts Rainbow("What year was '12 Years A Slave' released?").white.bright
      user_input = gets.chomp
      if user_input.downcase == "2013"
        puts Rainbow("Correct").green.bright
        counter += 1
      else
        puts Rainbow("Wrong").red.bright
      end
      puts Rainbow("Who played Don Vito Corleone in The Godfather?").white.bright
      user_input = gets.chomp
      if user_input.downcase == "marlon brando"
        puts Rainbow("Correct").green.bright
        counter += 1
      else
        puts Rainbow("Wrong").red.bright
      end
      puts Rainbow("What was the name of the diamond in 'Titanic' that many fans believe helped Gatsby make his wealth in 'The Great Gatsby'").white.bright
      user_input = gets.chomp
      if user_input.downcase == "rose’s heart of the ocean"
        puts Rainbow("Correct").green.bright
        counter += 1
      else
        puts Rainbow("Wrong").red.bright
      end
      if counter == 5
      puts Rainbow("You need to get out more! You scored #{counter}/5").green.bright
    elsif counter > 2 && counter < 5
      puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
    else
      puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
    end
    return_to_menu
  end
  def animation_quiz
    puts Rainbow("

  _|_|              _|                              _|      _|
_|    _|  _|_|_|        _|_|_|  _|_|      _|_|_|  _|_|_|_|        _|_|    _|_|_|
_|_|_|_|  _|    _|  _|  _|    _|    _|  _|    _|    _|      _|  _|    _|  _|    _|
_|    _|  _|    _|  _|  _|    _|    _|  _|    _|    _|      _|  _|    _|  _|    _|
_|    _|  _|    _|  _|  _|    _|    _|    _|_|_|      _|_|  _|    _|_|    _|    _|

      ").green.bright
      counter = 0
      puts Rainbow("How many years were there between the two Incredibles movies?").white.bright
      user_input = gets.chomp
      if user_input.downcase == "14"
        puts Rainbow("Correct").green.bright
        counter += 1
      else
        puts Rainbow("Wrong").red.bright
      end
      puts Rainbow("What yellow family made there way to the big screen in 2007?").white.bright
      user_input = gets.chomp
      if user_input.downcase == "the simpsons"
        puts Rainbow("Correct").green.bright
        counter += 1
      else
        puts Rainbow("Wrong").red.bright
      end
      puts Rainbow("Who played the voice of Buzz Lightyear in the Toy Story collection?").white.bright
      user_input = gets.chomp
      if user_input.downcase == "tim allen"
        puts Rainbow("Correct").green.bright
        counter += 1
      else
        puts Rainbow("Wrong").red.bright
      end
      puts Rainbow("What year was 'Cinderella' released?").white.bright
      user_input = gets.chomp
      if user_input.downcase == "1950"
        puts Rainbow("Correct").green.bright
        counter += 1
      else
        puts Rainbow("Wrong").red.bright
      end
      puts Rainbow("What would a forgetful blue fish suggest if you had a lot of code to do?").white.bright
      user_input = gets.chomp
      if user_input.downcase == "just keep coding"
        puts Rainbow("Correct").green.bright
        counter += 1
      else
        puts Rainbow("Wrong").red.bright
      end
      if counter == 5
      puts Rainbow("You need to get out more! You scored #{counter}/5").green.bright
    elsif counter > 2 && counter < 5
      puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
    else
      puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
    end
    return_to_menu
  end

  def quiz


  end

  # def all_movies_with_actors
  #   @all = all_movies_with_actors
  #   @all.each do |title, actors|
  #     puts "#{title}; #{actors}"
  #   end
  #   @all
  # end

  # def find_movies_for_actor
  #   input = gets_user_input
  #   actor_movies = movies.select do |title, name|
  #     name.split(", ") == actor
  #   end
  # end
  #
  # def find_actors_for_movie(movie)
  #   movie_actors = find_actors_for_movie.select do |title, name|
  #     name.split(", ") == actor
  #   end
end
