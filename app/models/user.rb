class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :portfolio
  after_create :create_portfolio

  # private

  def create_portfolio
    Portfolio.create!(user: self)
  end
end
