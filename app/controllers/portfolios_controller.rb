class PortfoliosController < ApplicationController
  
  def show
    @portfolio = current_user.portfolio
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
