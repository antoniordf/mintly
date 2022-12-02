class PortfolioCollectionsController < ApplicationController

  def create
    @collection = Collection.find(params[:collection_id])
    @portfolio_collection = PortfolioCollection.new
    @portfolio_collection.portfolio = current_user.portfolio
    @portfolio_collection.collection = @collection
    if @portfolio_collection.save!
      redirect_to portfolio_path(current_user.portfolio)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @portfolio_collection = PortfolioCollection.find(params[:id])
    @portfolio_collection.destroy
    redirect_to portfolios_path, status: :see_other
  end
end
