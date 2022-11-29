class PortfoliosController < ApplicationController

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new
    @portfolio.user = current_user
    @portfolio.save!
  end
end
