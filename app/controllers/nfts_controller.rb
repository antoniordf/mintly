class NftsController < ApplicationController
  before_action :find_collection

  def index
    @nfts = Nft.all
  end

  def show
    @nft = Nft.find(params[:id])
  end

  def new
    @nft = Nft.new
  end

  def create
    @nft = Nft.new(nft_params)
    @nft.collection = @collection
    if @nft.save
      redirect_to collection_portfolio_collections_path(@collection)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @collection = @nft.collection
  end

  def update
    if @nft.update(nft_params)
      redirect_to nft_path(@nft)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @nft.destroy
    redirect_to nfts_path, status: :see_other
  end

  private

  def find_collection
    @collection = Collection.find(params[:collection_id])
  end

  def nft_params
    params.require(:nft).permit(:name, :purchase_date, :purchase_price, :collection_id)
  end
end
