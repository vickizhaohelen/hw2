# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!
# - Note rubric explanation for appropriate use of external resources.

# Rubric
#
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)
# - You are welcome to use external resources for help with the assignment (including
#   colleagues, AI, internet search, etc). However, the solution you submit must
#   utilize the skills and strategies covered in class. Alternate solutions which
#   do not demonstrate an understanding of the approaches used in class will receive
#   significant deductions. Any concern should be raised with faculty prior to the due date.

# Submission
#
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======
# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========
# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Represented by agent
# ====================
# Christian Bale

# Generate models and tables, according to the domain model.
# rails generate model Studio name:string
# rails generate model Movie title:string release_year:integer mpaa_rating:string studio:references
# rails generate model Actor first_name:string last_name:string agent:references
# rails generate model Agent name:string
# rails generate model Casting movie:references actor:references character_name:string
# rails db:migrate

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
Casting.destroy_all
Movie.destroy_all
Actor.destroy_all
Studio.destroy_all

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
puts "Inserting studios..."
warner = Studio.create!(name: "Warner Bros.")
Studio.create!(name: "Universal Pictures")
Studio.create!(name: "Paramount Pictures")

puts "Inserting movies..."
bb = Movie.create!(
  title: "Batman Begins",
  release_year: 2005,
  mpaa_rating: "PG-13",
  studio: warner
)

tdk = Movie.create!(
  title: "The Dark Knight",
  release_year: 2008,
  mpaa_rating: "PG-13",
  studio: warner
)

tdkr = Movie.create!(
  title: "The Dark Knight Rises",
  release_year: 2012,
  mpaa_rating: "PG-13",
  studio: warner
)

puts "Inserting actors..."
actors = {
  "Christian Bale" => Actor.create!(first_name: "Christian", last_name: "Bale"),
  "Michael Caine" => Actor.create!(first_name: "Michael", last_name: "Caine"),
  "Liam Neeson" => Actor.create!(first_name: "Liam", last_name: "Neeson"),
  "Katie Holmes" => Actor.create!(first_name: "Katie", last_name: "Holmes"),
  "Gary Oldman" => Actor.create!(first_name: "Gary", last_name: "Oldman"),
  "Heath Ledger" => Actor.create!(first_name: "Heath", last_name: "Ledger"),
  "Aaron Eckhart" => Actor.create!(first_name: "Aaron", last_name: "Eckhart"),
  "Maggie Gyllenhaal" => Actor.create!(first_name: "Maggie", last_name: "Gyllenhaal"),
  "Tom Hardy" => Actor.create!(first_name: "Tom", last_name: "Hardy"),
  "Joseph Gordon-Levitt" => Actor.create!(first_name: "Joseph", last_name: "Gordon-Levitt"),
  "Anne Hathaway" => Actor.create!(first_name: "Anne", last_name: "Hathaway")
}

puts "Inserting castings..."
Casting.create!(movie: bb, actor: actors["Christian Bale"], character_name: "Bruce Wayne")
Casting.create!(movie: bb, actor: actors["Michael Caine"], character_name: "Alfred")
Casting.create!(movie: bb, actor: actors["Liam Neeson"], character_name: "Ra's al Ghul")
Casting.create!(movie: bb, actor: actors["Katie Holmes"], character_name: "Rachel Dawes")
Casting.create!(movie: bb, actor: actors["Gary Oldman"], character_name: "Commissioner Gordon")

Casting.create!(movie: tdk, actor: actors["Christian Bale"], character_name: "Bruce Wayne")
Casting.create!(movie: tdk, actor: actors["Heath Ledger"], character_name: "Joker")
Casting.create!(movie: tdk, actor: actors["Aaron Eckhart"], character_name: "Harvey Dent")
Casting.create!(movie: tdk, actor: actors["Michael Caine"], character_name: "Alfred")
Casting.create!(movie: tdk, actor: actors["Maggie Gyllenhaal"], character_name: "Rachel Dawes")

Casting.create!(movie: tdkr, actor: actors["Christian Bale"], character_name: "Bruce Wayne")
Casting.create!(movie: tdkr, actor: actors["Gary Oldman"], character_name: "Commissioner Gordon")
Casting.create!(movie: tdkr, actor: actors["Tom Hardy"], character_name: "Bane")
Casting.create!(movie: tdkr, actor: actors["Joseph Gordon-Levitt"], character_name: "John Blake")
Casting.create!(movie: tdkr, actor: actors["Anne Hathaway"], character_name: "Selina Kyle")

class Agent < ApplicationRecord
  has_many :actors
end
class Agent < ApplicationRecord
  has_many :actors
end

caa = Agent.create!(name: "Creative Artists Agency")

bale = Actor.find_by(last_name: "Bale")
if bale
  bale.update(agent: caa)
end

# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
def pad(text, width)
  text.to_s.ljust(width)
end

MOVIE_W = 20
YEAR_W  = 14
RATE_W  = 6
STUDIO_W = 20

ACTOR_W = 20
CHAR_W  = 22

# ===== Movies =====
puts "# Movies"
puts "# ======"

for m in Movie.includes(:studio).order(:release_year)
  line = "#{pad(m.title, MOVIE_W)} #{pad(m.release_year, YEAR_W)} #{pad(m.mpaa_rating, RATE_W)} #{m.studio&.name}"
  puts line
end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
Casting
  .includes(:movie, :actor)
  .joins(:movie)
  .order("movies.release_year ASC, castings.id ASC")
  .each do |c|
    actor_name = "#{c.actor.first_name} #{c.actor.last_name}"
    line =
      "#{pad(c.movie.title, MOVIE_W)}" \
      "#{pad(actor_name, ACTOR_W)}" \
      "#{c.character_name}"
    puts line
  end

# Prints a header for the agent's list of represented actors output
puts ""
puts "Represented by agent"
puts "===================="
puts ""

# Query the actor data and loop through the results to display the agent's list of represented actors output.
agents = Agent.all
for agent in agents
  puts agent.name
  for actor in agent.actors.order(:last_name, :first_name)
    puts "- #{actor.first_name} #{actor.last_name}"
  end
  puts ""
end