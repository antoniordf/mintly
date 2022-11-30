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

url_price_history = RestClient.get"https://api.rarify.tech/data/contracts/ethereum:0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D/insights/24h", {:Authorization => 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5'}
# url_price_history = RestClient.get"https://api.rarify.tech/data/contracts/ethereum:0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D/insights/7d", {:Authorization => 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5'} # 7days data for array
price_history = JSON.parse(url_price_history)
p price_history

user = User.new(
  email: "test@test.com",
  password: "123456"
)
user.save!

bored_ape_yacht_club = Collection.new(
  name: metadata["data"]["attributes"]["name"],
  description: metadata["data"]["attributes"]["description"],
  link: metadata["data"]["attributes"]["external_url"],
  image: "https://i.seadn.io/gae/i5dYZRkVCUK97bfprQ3WXyrT9BnLSZtVKGJlKQ919uaUB0sxbngVCioaiyu9r6snqfi2aaTyIvv6DHm4m2R3y7hMajbsv14pSZK8mhs?auto=format&w=2048",
  portfolio_id: user.portfolio.id
)
bored_ape_yacht_club.save!
p bored_ape_yacht_club

bored_ape_yacht_club_hitory = History.new(
  price: price_history["included"][0]["attributes"]["min_price"].to_f/1000000000000000000, ##24h price as a float
  # date_time: price_history["included"][1]["attributes"]["history"].map { |day| day["time"] },  ##as an array
  # date_time: price_history["included"][1]["attributes"]["history"].map { |price| price["time"] }, ##as an array
  collection_id: bored_ape_yacht_club.id
)
bored_ape_yacht_club_hitory.save!
p bored_ape_yacht_club_hitory
