class NftsController < ApplicationController
  before_action :find_collection, except: [:index]

  def index
    @nfts = Nft.where(portfolio: current_user.portfolio)
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
    @nft.portfolio = current_user.portfolio
    unless PortfolioCollection.where(portfolio: current_user.portfolio, collection: @collection).present?
      PortfolioCollection.create!(portfolio: current_user.portfolio, collection: @collection)
    end

    if @nft.save!
      redirect_to portfolio_path(current_user.portfolio)
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
    params.require(:nft).permit(:name, :purchase_date, :purchase_price, :purchase_quantity, :collection_id)
  end
end
