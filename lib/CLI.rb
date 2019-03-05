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
      quiz_genre
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

  def run
    input = gets_user_input
    x = find_or_create(input)
    puts Rainbow("   🎬 " + x.title + " 🎬").red.bright
    puts Rainbow("GENRE: " + x.genre).cyan.bright
    puts Rainbow(x.plot).white.bright
    puts Rainbow("Starring: " + x.all_actors_names).magenta.bright
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
    puts Rainbow("What sense must you live without in Birdbox").white.bright
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
  elsif counter > 2 && counter < 4
    puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
  else
    puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
  end
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
                                                                 puts Rainbow("Who is the cop battling with terrorists in 'Die Hard'?").white.bright
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
                                                               elsif counter > 2 && counter < 4
                                                                 puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
                                                               else
                                                                 puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
                                                               end
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
                                                                            elsif counter > 2 && counter < 4
                                                                              puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
                                                                            else
                                                                              puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
                                                                            end
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
                                                puts Rainbow("What is Napoleon Dynamite’s favorite sport??").white.bright
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
                                              elsif counter > 2 && counter < 4
                                                puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
                                              else
                                                puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
                                              end
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
     puts Rainbow("What movie does a burned madman come from the grave to kill with long sharp 'claws'?").white.bright
     user_input = gets.chomp
     if user_input.downcase == "a nightmare on elm street"
       puts Rainbow("Correct").green.bright
       counter += 1
     else
       puts Rainbow("Wrong").red.bright
     end
     puts Rainbow("What sense must you live without in Birdbox").white.bright
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
   elsif counter > 2 && counter < 4
     puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
   else
     puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
   end
  end
  def drama_quiz
    puts Rainbow("
      ########  ########     ###    ##     ##    ###
      ##     ## ##     ##   ## ##   ###   ###   ## ##
      ##     ## ##     ##  ##   ##  #### ####  ##   ##
      ##     ## ########  ##     ## ## ### ## ##     ##
      ##     ## ##   ##   ######### ##     ## #########
      ##     ## ##    ##  ##     ## ##     ## ##     ##
      ########  ##     ## ##     ## ##     ## ##     ## ").lavender.bright
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
      puts Rainbow("What sense must you live without in Birdbox").white.bright
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
    elsif counter > 2 && counter < 4
      puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
    else
      puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
    end
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
      puts Rainbow("What sense must you live without in Birdbox").white.bright
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
    elsif counter > 2 && counter < 4
      puts Rainbow("You're on the way to being an expert. You scored #{counter}/5").orange.bright
    else
      puts Rainbow("Terrible! You need to spend more time on our database! You scored #{counter}/5").red.bright
    end
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
  # end
end
