# a1 = Actor.create(name: "Dwayne Johnson", gender: "M", age: 46)
# a3 = Actor.create(name: "Jason Statham", gender: "M", age: 51)
# a4 = Actor.create(name: "Jessica Alba", gender: "F", age: 37)
# a5 = Actor.create(name: "Jennifer Aniston", gender: "F", age: 50)
# a6 = Actor.create(name: "Adam Sandler", gender: "M", age: 52)
#
# m1 = Movie.create(title: "Just Go With It", genre: "Comedy", release_date: 2011, review: "A funny light comedy to watch on a cozy night, a fimiliar story line see's a wealthy man trying to win the heart of a younger woman out of his league. things get complicated when his lies catch up to him and he has to think of creative and expensive soloutions. The many unusual details in this film that should keep you laughing through out")
# m2 = Movie.create(title: "Mechanic: Resurrection", genre: "Action", release_date: 2016, review: "An action filmed movie with the serious Jason Statham playing the seclueded hard man we have become used to. Entertaing watch which of course includes sevral ways to win fights you would never in a milion years think of! A sequal to the original Mechanic a now retired hitman must come out the shadows to settle some old scores")
# m3 = Movie.create(title: "The Transporter", genre: "Action", release_date: 2002, review: "What more can you want from an action movie? Fight scenes, fast driving witty banter and a decent storyline. One of the best drivers in the criminal world takes a job but when his rules are broken the job changes!")
# m4 = Movie.create(title: "The Fate Of The Furious", genre: "Action", release_date: 2017, review: "The latest in the Fast 'n' Furious franchise sees the return of some old favorites joining together as a team littered with good guys and bad guys to fight the latest wave of criminals. Like all the previous movies if you want fight scenes, fast cars and smart hiests you wont be disapointed.")
# m5 = Movie.create(title: "I Am Legend", genre: "Thriller", release_date: 2007, review: "A unrecognisable New York following an outbreak killing many and causing the rest to flee. All thats left is Will Smith and his loyal dog as he still tries to find a cure whilst dodging the infected still in New York.")
# m6 = Movie.create(title: "Suicide Squad", genre: "Fantasy", release_date: 2016, review: "A much anticipated DC spin off a squad of the most evil encarcerated vilans is assembled as the big boys think they must fight evil with evil. But how much does anyone really trust each other?")



require 'rest-client'
require 'json'

url = "http://www.omdbapi.com/?i=tt3896198&apikey=dc2f1dca"
response = RestClient.get(url)
response_hash = JSON.parse(response)


# ma1 = MovieActors.create(movie_id: 1, actor_id: 6)
# ma2 = MovieActors.create(movie_id: 1, actor_id: 7)
