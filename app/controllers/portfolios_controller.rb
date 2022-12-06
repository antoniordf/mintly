class PortfoliosController < ApplicationController
  def show
    @portfolio = current_user.portfolio

    @data = {}
    end_date = Date.today
    start_date = end_date - params[:period].to_i.days

    (start_date..end_date).each do |date|
      @data[date] = @portfolio.value_on_date(date)
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
