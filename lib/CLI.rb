require 'rest-client'
require 'json'
require 'rainbow'


url = "http://www.omdbapi.com/?i=tt3896198&apikey=dc2f1dca"
response = RestClient.get(url)
response_hash = JSON.parse(response)


class CommandLine

prompt = TTY::Prompt.new

  def json_url(name)
    search_name = name.sub(" ", "+")
    url = "http://www.omdbapi.com/?t=#{search_name}&apikey=dc2f1dca"
    response = RestClient.get(url)
    response_hash = JSON.parse(response)
  end

  def return_to_menu
    puts Rainbow("\nWould you like to return to the menu?").white.bright
    prompt = TTY::Prompt.new
  choices = [
  { name: Rainbow('Yes').green.bright},
  { name: Rainbow('No').red.bright}
]
answer = prompt.select("Select option", choices, cycle: true)
    if  answer == Rainbow('Yes').green.bright
        menu
        menu_choice
    elsif answer == Rainbow('No').red.bright
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
    prompt = TTY::Prompt.new
  choices = [
  { name: Rainbow('Search a movie').white.bright},
  { name: Rainbow('Search movies for a actor').white.bright},
  { name: Rainbow('See top 10 movies').white.bright},
  { name: Rainbow('See top 10 actors').white.bright},
  { name: Rainbow('Quiz!').white.bright},
  { name: Rainbow('Quit').white.bright}
]
answer = prompt.select("Select option", choices, cycle: true)
    if  answer == Rainbow('Search a movie').white.bright
      run_movie
    elsif answer == Rainbow('Search movies for a actor').white.bright
      all_movies_for_actor
    elsif answer == Rainbow('See top 10 movies').white.bright
      top_10_movies
    elsif answer == Rainbow('See top 10 actors').white.bright
      top_10_actors
    elsif answer == Rainbow('Quiz!').white.bright
      quiz_genre
    elsif answer == Rainbow('Quit').white.bright
        abort
    end
  end


  def gets_user_input
    puts Rainbow("\n    Search:").white.bright
    find_movie = gets.chomp
  end

  def find_or_create(input)
    movie_hash = json_url(input)
    movie = Movie.find_or_create_by(title: movie_hash["Title"], genre: movie_hash["Genre"], release_date: movie_hash["Year"], plot: movie_hash["Plot"], all_actors_names: movie_hash["Actors"], rating: movie_hash["imdbRating"])
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

  def ratings_for_actor(input)
     af1 = Actor.find_by(name: input)
     af1.movies
     binding.pry
      af1.movies.collect do |movie|
         movie.rating
    end
    binding.pry
  end

  def average_ratings_for_actor
    puts Rainbow("\n    Search:").white.bright
    input = gets.chomp
    total = ratings_for_actor(input).inject(:+)
    average = total / ratings_for_actor(input).length.to_f
    puts average.round(2)
  end

  def top_10_movies
    movie_rating = Movie.all
    test = movie_rating.max_by(10) do |hash|
      hash[:rating]
  end
  ranking = 10
  count = 0
    test.select do |movie|
      count += 1
      score = Rainbow(movie[:rating]).green.bright
      puts Rainbow("#{count}. " + movie[:title] + "   " + score).white.bright
    end
    plus_10
    return_to_menu
end

def plus_10
  count = 0
  ranking = 10
  puts Rainbow("Do you want to see the next 10?").cyan.bright
  prompt = TTY::Prompt.new
choices = [
{ name: Rainbow('Yes').green.bright},
{ name: Rainbow('No').red.bright}
]
answer = prompt.select("Select option", choices, cycle: true)
  if  answer == Rainbow('Yes').green.bright
    movie_rating = Movie.all
    test = movie_rating.max_by(ranking+=10) do |hash|
      hash[:rating]
    end
    test.select do |movie|
      count += 1
      score = Rainbow(movie[:rating]).green.bright
      puts Rainbow("#{count}. " + movie[:title] + "   " + score).white.bright
    end
  elsif answer == Rainbow('No').red.bright
    return_to_menu
  end
end

  def all_actor_ratings
    actors_with_average_rating = Actor.all.map do |actor|
      avg = actor.movies.inject(0){|acc, i|  acc + i.rating}
      {name: actor.name, avg_rating: (avg / actor.movies.length).round(2)}
    end
end

  def top_10_actors
    test = all_actor_ratings.max_by(10) do |hash|
      hash[:avg_rating]
  end
  count = 0
    test.select do |actor|
      count += 1
      score = Rainbow(actor[:avg_rating]).green.bright
      puts Rainbow("#{count}. " + actor[:name] + "   " + score).white.bright
    end
    plus_10_actor
    return_to_menu
end

def plus_10_actor
  count = 0
  ranking = 10
  puts Rainbow("Do you want to see the next 10?").cyan.bright
  prompt = TTY::Prompt.new
choices = [
{ name: Rainbow('Yes').green.bright},
{ name: Rainbow('No').red.bright}
]
answer = prompt.select("Select option", choices, cycle: true)
  if  answer == Rainbow('Yes').green.bright
    test = all_actor_ratings.max_by(ranking+=10) do |hash|
      hash[:avg_rating]
    end
    test.select do |actor|
      count += 1
      score = Rainbow(actor[:avg_rating]).green.bright
      puts Rainbow("#{count}. " + actor[:name] + "   " + score).white.bright
    end
  elsif answer == Rainbow('No').red.bright
    return_to_menu
  end
end

  def run_movie
    input = gets_user_input
    find_or_create(input)
    return_to_menu
  end

  def quiz_genre
    prompt = TTY::Prompt.new
    puts Rainbow("    Test your knowledge and choose a catagory or if your feeling brave try out ultimate quiz!
          Please select an option by typing the corresponding number:").red.bright
  choices = [
  { name: Rainbow('Horror 🧟').white.bright},
  { name: Rainbow('Comedy 🤣').white.bright},
  { name: Rainbow('Action 🚓').white.bright},
  { name: Rainbow('Sci-Fi 🦸‍').white.bright},
  { name: Rainbow('Drama 😱').white.bright},
  { name: Rainbow('Animation 🧞').white.bright},
  { name: Rainbow('All 🎥').white.bright},
  { name: Rainbow('Quit').white.bright}
]
answer = prompt.select("Select option", choices, cycle: true)
    if  answer == Rainbow('Horror 🧟').white.bright
      horror_quiz
    elsif answer == Rainbow('Comedy 🤣').white.bright
      comedy_quiz
    elsif answer == Rainbow('Action 🚓').white.bright
      action_quiz
    elsif answer == Rainbow('Sci-Fi 🦸‍').white.bright
      sci_fi_quiz
    elsif answer == Rainbow('Drama 😱').white.bright
      drama_quiz
    elsif answer == Rainbow('Animation 🧞').white.bright
      animation_quiz
    elsif answer == Rainbow('All 🎥').white.bright
      all_quiz
    elsif answer == Rainbow('Quit').white.bright
      menu
      menu_choice
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
    puts Rainbow("What sense must you live without in Bird Box?").white.bright
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
                                                                              puts Rainbow("What film features Keanu Reeves in a long leather black jacket?").white.bright
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
                                                puts Rainbow("What nationality is Borat?").white.bright
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
     puts Rainbow("What is the name of the hobbit played by Elijah Wood in the Lord of the Rings movies?").white.bright
     user_input = gets.chomp
     if user_input.downcase == "frodo baggins"
       puts Rainbow("Correct").green.bright
       counter += 1
     else
       puts Rainbow("Wrong").red.bright
     end
     puts Rainbow("Which 1997 science fiction movie tells the story of a secret agency that polices alien refugees who are living on earth disguised as humans?").white.bright
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

  def all_actors_for_movie
    puts "Search a movie to find all the actors who featured;"
    input = gets.chomp
    movie = Movie.find_by(title: input)
    movie.actors.each do |actor|
      puts actor.name
    end
  end
end
