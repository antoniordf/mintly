class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    # redirect_to portfolio_path(current_user.portfolio) if user_signed_in?
  end
end
