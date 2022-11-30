class NftsController < ApplicationController
  before_action :find_collection

  def index
    @nfts = Nft.all
  end

  def show
    @nft = Nft.find(params[:id])
  end



  def find_collection
    @collection = Collection.find(params[:collection_id])
  end
end
