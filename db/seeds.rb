require "json"
require "rest-client"

PortfolioCollection.destroy_all
History.destroy_all
Collection.destroy_all
Portfolio.destroy_all
User.destroy_all
puts "Database cleared!"

url_metadata = RestClient.get "https://api.rarify.tech/data/contracts?filter[network]=ethereum", { Authorization: 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5' }
metadata = JSON.parse(url_metadata)

# url_price_history = RestClient.get"https://api.rarify.tech/data/contracts/ethereum:0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D/insights/24h", {:Authorization => 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5'}
# url_price_history = RestClient.get "https://api.rarify.tech/data/contracts/ethereum:0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D/insights/90d", { Authorization: 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5' } # 7days data for array
# price_history = JSON.parse(url_price_history)

collections = [
  "0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D",
  "0xb47e3cd837dDF8e4c57F05d70Ab865de6e193BBB",
  "0xc99c679C50033Bbc5321EB88752E89a93e9e83C5",
  "0x8a90CAb2b38dba80c64b7734e58Ee1dB38B8992e",
  "0xED5AF388653567Af2F388E6224dC7C4b3241C544",
  "0x34d85c9CDeB23FA97cb08333b511ac86E1C4E258",
  "0x23581767a106ae21c074b2276D25e5C3e136a68b",
  "0xba30E5F9Bb24caa003E9f2f0497Ad287FDF95623",
  "0x7Bd29408f11D2bFC23c34f18275bBf23bB716Bc7",
  "0x1A92f7381B9F03921564a437210bB9396471050C",
  "0x9251dEC8DF720C2ADF3B6f46d968107cbBADf4d4",
  "0x86CC280D0BAC0BD4Ea38ba7d31e895Aa20Cceb4b",
  "0x6c410cF0B8c113Dc6A7641b431390B11d5515082",
  "0x8F41FC6daED55B1955dBb72099Ac26D295e34F75"
]

User.create!(
  email: "test@test.com",
  password: "1234567"
)
puts "User created"

collections.each do |collection|
  url_metadata = RestClient.get "https://api.rarify.tech/data/contracts/ethereum:#{collection}", { Authorization: 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5' }
  metadata = JSON.parse(url_metadata)

  Collection.create!(
    name: metadata["data"]["attributes"]["name"],
    description: metadata["data"]["attributes"]["description"],
    link: metadata["data"]["attributes"]["external_url"],
    image: metadata["data"]["attributes"]["image_url"],
    contract_id: metadata["data"]["id"]
  )
  puts "Collection created"

  puts "Reading api...."
  url_price_history = RestClient.get "https://api.rarify.tech/data/contracts/#{metadata['data']['id']}/insights/90d", { Authorization: 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5' }
  price_history = JSON.parse(url_price_history)

  items = price_history["included"][1]["attributes"]["history"]

  next if items.nil?

  items.each do |item|
    if item["min_price"].to_i * 1.8 < price_history["included"][0]["attributes"]["avg_price"].to_i
      item["min_price"] = price_history["included"][0]["attributes"]["avg_price"]
    end

    History.create!(collection: Collection.last,
                    date_time: item["time"],
                    price: item["min_price"].to_f / 1_000_000_000_000_000_000)
  end
end

# url_price_history = RestClient.get "https://api.rarify.tech/data/contracts/ethereum:0xb47e3cd837dDF8e4c57F05d70Ab865de6e193BBB/insights/90d", { Authorization: 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5' }
# price_history = JSON.parse(url_price_history)
# pp price_history

# items = price_history["included"][1]["attributes"]["history"]

# updated_items = items.map do |item|
#   puts "BEFORE"
#   pp item
#   if item["min_price"].to_i * 3 < price_history["included"][0]["attributes"]["avg_price"].to_i
#     item["min_price"] = price_history["included"][0]["attributes"]["avg_price"]
#   end
#   puts "AFTER"
#   pp item
# end
