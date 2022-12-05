class PortfoliosController < ApplicationController

  def show
    @portfolio = current_user.portfolio

    # get latest floor price of collection
    # get purchase price of NFT
    # get quantity purchased of nft
    # for each day calculate value of portfolio
    # calculate PL
    data = {}
    @portfolio.collections.each do |collection|
      collection.nfts.each do |nft|
        data[nft.id] = {}
        data[nft.id]["price"] = nft.purchase_price
        data[nft.id]["quantity"] = nft.purchase_quantity
        data[nft.id]["purchase_date"] = nft.purchase_date
        data[nft.id]["floor_price"] = collection.histories.last.price
      end
    end

  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new
    @portfolio.user = current_user
    @portfolio.save!
  end
end
