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


q1 = Question.create(genre: "horror", question: "What movie is the character Norman Bates in?", answer: "psycho")
q2 = Question.create(genre: "horror", question: "What movie is the character Samara in?", answer: "the ring")
q3 = Question.create(genre: "horror", question: "What movie is the character Jason Voorhees in?", answer: "friday the 13th")
q4 = Question.create(genre: "horror", question: "Who plays IT in the 2017 film IT?", answer: "bill skarsgard")
q5 = Question.create(genre: "horror", question: "Who plays Jack in the 2011 film The Shining?", answer: "jack nicholson")
q6 = Question.create(genre: "horror", question: "Who plays possessed Regan MacNeil in the 1974 film The Exorcist?", answer: "linda blair")
q7 = Question.create(genre: "horror", question: "What movie does a burned madman come from the grave to kill with long sharp 'claws'?", answer: "a nightmare on elm street")
q8 = Question.create(genre: "horror", question: "What sense must you live without in Birdbox?", answer: "sight")
q9 = Question.create(genre: "horror", question: "Who plays the lead role in Get Out?", answer: "daniel kaluuya")
q10 = Question.create(genre: "horror", question: "How old was Micheal Myers when he killed his first victim in Halloween", answer: "6")

q11 = Question.create(genre: "comedy", question: "What movie is the character Jack Sparrow in?", answer: "pirates of the caribbean")
q12 = Question.create(genre: "comedy", question: "What movie is the character Ron Burgundy in?", answer: "anchorman")
q13 = Question.create(genre: "comedy", question: "What movie are the characters Phil, Stu, Alan and Doug in?", answer: "the hangover")
q14 = Question.create(genre: "comedy", question: "Who plays Shaun in the 2004 film Shaun of the dead?", answer: "simon pegg")
q15 = Question.create(genre: "comedy", question: "Who plays Scott Pilgrim in the 2010 film Scott Pilgrim vs. the World?", answer: "michael cera")
q16 = Question.create(genre: "comedy", question: "Who plays Greg Focker in the 2000 film Meet The Parents?", answer: "ben stiller")
q17 = Question.create(genre: "comedy", question: "In what movie does the Stay Puft Marshmallow Man begin destroying New York City?", answer: "ghostbusters")
q18 = Question.create(genre: "comedy", question: "What is Napoleon Dynamite’s favorite sport?", answer: "tetherball")
q19 = Question.create(genre: "comedy", question: "In “Wedding Crashers,” what does Will Ferrell’s character crash?", answer: "funerals")
q20 = Question.create(genre: "comedy", question: "What nationality is Borat", answer: "kazakhstan")

q21 = Question.create(genre: "action", question: "What movie is the character Sarah Connor in?", answer: "terminator")
q22 = Question.create(genre: "action", question: "What collection of movies is the character Dominic Toretto in?", answer: "fast and furious")
q23 = Question.create(genre: "action", question: "What movie is the character Ethan Hunt in?", answer: "mission impossible")
q24 = Question.create(genre: "action", question: "Who plays Indiana Jones in the 1981 film Raiders of the Lost Ark?", answer: "harrison ford")
q25 = Question.create(genre: "action", question: "Who plays Jason Bourne in the 2002 film The Bourne Identity?", answer: "matt damon")
q26 = Question.create(genre: "action", question: "Who plays Leonidas in the 2006 film 300?", answer: "gerard butler")
q27 = Question.create(genre: "action", question: "Who directed the movies 'Jaws', 'Schindler's List' and 'Jurassic Park'?", answer: "stephen spielberg")
q28 = Question.create(genre: "action", question: "Which films are about the Corleone family?", answer: "the godfather")
q29 = Question.create(genre: "action", question: "Who plays the cop battling with terrorists in 'Die Hard'?", answer: "bruce willis")
q30 = Question.create(genre: "action", question: "Which 1970s film about a giant animal was a remake of a 1933 movie?", answer: "king kong")

q31 = Question.create(genre: "sci-fi", question: "What movie is the character John Hammond in?", answer: "jurrasic park")
q32 = Question.create(genre: "sci-fi", question: "What movie is the character Neytiri in?", answer: "avatar")
q33 = Question.create(genre: "sci-fi", question: "What movie is the character Tony Stark in?", answer: "iron man")
q34 = Question.create(genre: "sci-fi", question: "Who plays Hulk in the 2012 film The Avengers?", answer: "mark ruffalo")
q35 = Question.create(genre: "sci-fi", question: "Who plays Mark Watney in the 2015 film The Martian?", answer: "matt damon")
q36 = Question.create(genre: "sci-fi", question: "Who plays Gertie in the 1982 film E.T?", answer: "drew barrymore")
q37 = Question.create(genre: "sci-fi", question: "What former governor was famous for saying 'I'll be back'?", answer: "arnold schwarzenegger")
q38 = Question.create(genre: "sci-fi", question: "What film features Keanu Reeves in a long leather black jacket", answer: "the matrix")
q39 = Question.create(genre: "sci-fi", question: "Who played Bane in Dark Night Rises?", answer: "tom hardy")
q40 = Question.create(genre: "sci-fi", question: "Who can snap their fingers and destroy half of humanity?", answer: "thanos")

q41 = Question.create(genre: "drama", question: "What movie is the character Rick Blaine in?", answer: "casablanca")
q42 = Question.create(genre: "drama", question: "What movie is the character Katniss Everdeen in?", answer: "the hunger games")
q44 = Question.create(genre: "drama", question: "Who plays Ellis Boyd Redding in the 1994 film The Shawshank Redemption?", answer: "morgan freeman")
q45 = Question.create(genre: "drama", question: "Who plays Aibileen Clark in the 2011 film The Help?", answer: "viola davis")
q46 = Question.create(genre: "drama", question: "Who plays Travis Bickle in the 1976 film Taxi Driver?", answer: "robert de niro")
q47 = Question.create(genre: "drama", question: "Who played Don Vito Corleone in The Godfather?", answer: "marlon brando")
q48 = Question.create(genre: "drama", question: "What year was '12 Years A Slave' released?", answer: "2013")
q49 = Question.create(genre: "drama", question: "What movie did Leonardo DiCaprio win a long awaited Oscar for?", answer: "the revenant")
q50 = Question.create(genre: "drama", question: "In which city was the film 'The Elephant Man' set?", answer: "london")

q51 = Question.create(genre: "animation", question: "What movie is the character Elsa in?", answer: "frozen")
q52 = Question.create(genre: "animation", question: "What movie is the character Timon in?", answer: "the lion king")
q53 = Question.create(genre: "animation", question: "What movie is the character Fiona?", answer: "shrek")
q54 = Question.create(genre: "animation", question: "Who plays Remy in the 2007 film Ratatouille?", answer: "patton oswalt")
q55 = Question.create(genre: "animation", question: "Who plays Maui in the 2016 film Moana?", answer: "dwayne johnson")
q56 = Question.create(genre: "animation", question: "Who plays Emmet in the 2014 film The Lego Movie?", answer: "chris pratt")
q57 = Question.create(genre: "animation", question: "What year was 'Cinderella' released?", answer: "1950")
q58 = Question.create(genre: "animation", question: "Who played the voice of Buzz Lightyear in the Toy Story collection?", answer: "tim allen")
q59 = Question.create(genre: "animation", question: "What yellow family made there way to the big screen in 2007?", answer: "the simpsons")
q60 = Question.create(genre: "animation", question: "How many years were there between the two Incredibles movies?", answer: "14")

q61 = Question.create(genre: "all", question: "How many dream levels do they get to in Inception?", answer: "5")
q62 = Question.create(genre: "all", question: "How many James Bond movies are there?", answer: "26")
q63 = Question.create(genre: "all", question: "What is the name of the hobbit played by Elijah Wood in the Lord of the Rings movies", answer: "frodo baggins")
q64 = Question.create(genre: "all", question: "Which 1997 science fiction movie tells the story of a secret agency that polices alien refugees who are living on earth disguised as humans", answer: "men in black")
q65 = Question.create(genre: "all", question: "Which Tom Hanks movie won the Academy Award for Best Picture in 1994?", answer: "forrest gump")


# ma1 = MovieActors.create(movie_id: 1, actor_id: 6)
# ma2 = MovieActors.create(movie_id: 1, actor_id: 7)
