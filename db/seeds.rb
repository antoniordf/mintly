# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "rest-client"
response = RestClient.get"https://api.rarify.tech/data/contracts/ethereum:0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D", {:Authorization => 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5'}
repos = JSON.parse(response)
# => repos is an `Array` of `Hashes`.

# repos.size
p repos
collection1 = Collection.new(
  description:
  name:
  
)

collection1.save!
