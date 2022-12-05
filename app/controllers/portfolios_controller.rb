class PortfoliosController < ApplicationController
  def show
    @portfolio = current_user.portfolio

    # @data = {}
    # end_date = Date.today
    # start_date = end_date - 3.days

    # (start_date..end_date).each do |date|
    #   @data[date] = @portfolio.value_on_date(date)
    # end

    # @portfolio.collections.each do |collection|
    #   collection.nfts.each do |nft|
    #     data[nft.id] = {}
    #     data[nft.id]["price"] = nft.purchase_price
    #     data[nft.id]["quantity"] = nft.purchase_quantity
    #     data[nft.id]["purchase_date"] = nft.purchase_date
    #     data[nft.id]["floor_price"] = collection.histories.last.price
    #   end
    # end

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
