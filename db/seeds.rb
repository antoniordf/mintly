# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "rest-client"
url_metadata = RestClient.get "https://api.rarify.tech/data/contracts?filter[network]=ethereum", { Authorization: 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5' }
metadata = JSON.parse(url_metadata)

# url_price_history = RestClient.get"https://api.rarify.tech/data/contracts/ethereum:0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D/insights/24h", {:Authorization => 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5'}
# url_price_history = RestClient.get "https://api.rarify.tech/data/contracts/ethereum:0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D/insights/90d", { Authorization: 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5' } # 7days data for array
# price_history = JSON.parse(url_price_history)

collections = [
  "0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D",
  "0xb47e3cd837dDF8e4c57F05d70Ab865de6e193BBB",
  "0x8a90CAb2b38dba80c64b7734e58Ee1dB38B8992e",
  "0xED5AF388653567Af2F388E6224dC7C4b3241C544",
  "0x60E4d786628Fea6478F785A6d7e704777c86a7c6",
  "0x34d85c9CDeB23FA97cb08333b511ac86E1C4E258",
  "0xED5AF388653567Af2F388E6224dC7C4b3241C544",
  "0xa7d8d9ef8D8Ce8992Df33D8b8CF4Aebabd5bD270",
  "0x23581767a106ae21c074b2276D25e5C3e136a68b",
  "0xa3AEe8BcE55BEeA1951EF834b99f3Ac60d1ABeeB",
  "0xba30E5F9Bb24caa003E9f2f0497Ad287FDF95623",
  "0x7Bd29408f11D2bFC23c34f18275bBf23bB716Bc7",
  "0x1A92f7381B9F03921564a437210bB9396471050C"
]

user = User.create!(
  email: "test@test.com",
  password: "123456"
)

collections.each do |collection|
  url_metadata = RestClient.get "https://api.rarify.tech/data/contracts/ethereum:#{collection}", { Authorization: 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5' }
  metadata = JSON.parse(url_metadata)

  Collection.create!(
    name: metadata["data"]["attributes"]["name"],
    description: metadata["data"]["attributes"]["description"],
    link: metadata["data"]["attributes"]["external_url"],
    image: metadata["data"]["attributes"]["image_url"],
  )

  url_price_history = RestClient.get "https://api.rarify.tech/data/contracts/#{metadata['data']['id']}/insights/7d", { Authorization: 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5' }
  price_history = JSON.parse(url_price_history)

  items = price_history["included"][1]["attributes"]["history"]
  items.each do |item|
    History.create!(collection: Collection.last,
                    date_time: item["time"],
                    price: (item["min_price"].to_f / 1_000_000_000_000_000_000))
  end
end
