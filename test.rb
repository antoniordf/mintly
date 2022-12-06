  # items_p = items["min_price"]
  # larger_numbers = []
  # prev = nil

  # items_p.each do |item|
  #   if prev.nil?
  #     prev = item
  #   else
  #     if (item - prev).abs / prev > 0.5
  #       larger_numbers << item
  #     end
  #     prev = item
  #   end
  # end

  # items.each do |item|
  #   History.create!(collection: Collection.last,
  #                   date_time: item["time"],
  #                   price: item["min_price"].to_f / 1_000_000_000_000_000_000)
  #   puts "History created"
  # end

  # items.each_cons(2) do |item1, item2|
  #   first = item1["min_price"].to_f / 1_000_000_000_000_000_000
  #   last = item2["min_price"].to_f / 1_000_000_000_000_000_000
  #   History.create!(collection: Collection.last,
  #                   date_time: item1["time"],
  #                   price: (last - first).abs / first > 0.5 ? first : last)
  #   puts "History created"
  # end

  price = [60.1, 61.5, 0.2, 60.8, 20.5, 15.1, 0.1, 62.3, 62.1, 60.0, 0.3, 61.3]

  array = []
  puts overall_average = price.sum / price.length
  current = price[0]

  price.each_with_index do |p, index|
    next unless price[index - 1]
    if p < overall_average
      puts p < (price[index - 1] / 2)
      puts "the current price is #{p}. the previous price is #{current}"
      array << current
      current = price[index - 1]
    else
      array << p
    end
  end

  puts array
