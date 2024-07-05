# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'
require 'open-uri'

Movie.destroy_all

response = URI.open('https://tmdb.lewagon.com/movie/top_rated').read

json = JSON.parse(response)
movie_results = json['results']
movie_results.each do |movie|
  Movie.create!(
    {
      title: movie['original_title'],
      overview: movie['overview'],
      poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
      rating: movie['vote_average'].round(1)
    }
  )
end

# 20.times do
#   Movie.create!(
#     {
#       title: Faker::Movie.title,
#       overview: Faker::Movie.quote,
#       poster_url: 'https://picsum.photos/200',
#       rating: rand(1.0..10.0).round(1)
#     }
#   )
# end
