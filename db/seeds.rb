require "open-uri"
require "yaml"

file = "https://gist.githubusercontent.com/pbragamiranda/2e7b4954503c088f474ab4d16d8389dd/raw/5c46f34096dcb01fc15b0abb893a6371616b6340/imdb.yml"
sample = YAML.load(open(file).read)

puts 'Creating directors...'
directors = {}  # slug => Director
sample["directors"].each do |director|
  directors[director["slug"]] = Director.create! director.slice("first_name", "last_name")
end

puts 'Creating movies...'
sample["movies"].each do |movie|
  Movie.create! movie.slice("title", "year", "synopsis").merge(director: directors[movie["director_slug"]])
end

puts 'Creating tv shows...'
sample["series"].each do |tv_show|
  TvShow.create! tv_show
end
puts 'Finished!'
