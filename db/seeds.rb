# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "rest-client"
url_metadata = RestClient.get"https://api.rarify.tech/data/contracts/ethereum:0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D", {:Authorization => 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5'}
metadata = JSON.parse(url_metadata)

url_price_history = RestClient.get"https://api.rarify.tech/data/contracts/ethereum:0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D/insights/90d", {:Authorization => 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5'}
price_history = JSON.parse(url_price_history)

# p metadata
# p price_history

user = User.new(
  email: "haogaoren13@gmail.com",
  password: "123456"
)
user.save!

bored_ape_yacht_club = Collection.new(
  description: metadata["data"]["attributes"]["description"],
  name: metadata["data"]["attributes"]["name"],
  portfolio_id: user.portfolio.id
)
bored_ape_yacht_club.save!
p bored_ape_yacht_club
