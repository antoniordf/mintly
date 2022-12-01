class PortfolioCollectionsController < ApplicationController
  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @portfolio_collection = Portfolio_collection.new
    @portfolio_collection.user = current_user
    @portfolio_collection.portfolio = @portfolio
    if @portfolio_collection.save
      redirect_to portfolios_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @portfolio_collection = Portfolio_collection.find(params[:id])
    @portfolio_collection.destroy
    redirect_to portfolios_path, status: :see_other
  end

end
