class PortfolioCollectionsController < ApplicationController

  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @portfolio_collection = PortfolioCollection.new
    @portfolio_collection.user = current_user
    @portfolio_collection.portfolio = @portfolio
    if @portfolio_collection.save
      redirect_to portfolios_path
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
