class CollectionsController < ApplicationController
  def index
    if params[:query].present?
      if Collection.search_by_name(params[:query]).present?
        @collections = Collection.search_by_name(params[:query])
      else
        url_metadata = RestClient.get "https://api.rarify.tech/data/contracts?filter[name]=#{params[:query]}", { Authorization: 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5' }
        results = JSON.parse(url_metadata)["data"]
        results_with_image = []
        results.each do |a|
          if a["attributes"]["image_url"].present? && a["attributes"]["image_url"].include?("http")
            results_with_image << a
          else
            a["attributes"]["image_url"] = "placeholder"
            results_with_image << a
          end
        end
        results = results_with_image.reject { |a| Collection.all.map(&:name).include?(a["attributes"]["name"]) }
        if results.any?
          results = Collection.insert_all(
            bulk_insert_collection_params(results)
          )
          @collections = Collection.where(id: results.rows.flatten).search_by_name(params[:query])
        else
          @collections = []
        end
        return @collections
      end
    else
      @collections = Collection.all
    end
  end

  def show
    @collection = Collection.find(params[:id])
    if @collection.histories.empty?
      url_price_history = RestClient.get "https://api.rarify.tech/data/contracts/#{@collection.contract_id}/insights/90d", { Authorization: 'Bearer 6d42ff96-f7b6-4abd-8c87-b097789b71d5' }
      results = JSON.parse(url_price_history)
      if results["included"][0]["attributes"]["history"].nil?
        data = results["included"][1]["attributes"]["history"]
      else
        data = results["included"][0]["attributes"]["history"]
      end

      # results = price_history["included"][1]["attributes"]["history"]
      # next if results.nil?
      # results.each do |result|
      # if result["min_price"].to_i * 2 < price_history["included"][0]["attributes"]["avg_price"].to_i
      #   result["min_price"] = price_history["included"][0]["attributes"]["avg_price"]
      # end

      History.insert_all(bulk_insert_prices(data))
    else
      @collection.histories
    end
    @reversed_nfts_collections = @collection.nfts.where(portfolio: current_user.portfolio).reverse
  end

  private

  def bulk_insert_prices(api_results)
    api_results.map do |api_result|
      {
        collection_id: params[:id],
        date_time: api_result["time"],
        price: (api_result["avg_price"].to_f / 1_000_000_000_000_000_000)
      }
    end
  end

  def bulk_insert_collection_params(api_results)
    api_results.map do |api_result|
      {
        name: api_result["attributes"]["name"],
        description: api_result["attributes"]["description"],
        link: api_result["attributes"]["external_url"],
        image: api_result["attributes"]["image_url"],
        contract_id: api_result["id"]
      }
    end
  end

  def collection_params
    params.require[:collection].permit(:name, :description, :image, :link, :contract_id)
  end
end
