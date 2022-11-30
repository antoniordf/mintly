class CollectionsController < ApplicationController

  def index
    @collections = Collection.all
  end

  def show
    @collection = Collection.find(params[:id])
  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(collection_params)
    @collection.save!
  end

  private

  def collection_params
    params.require[:collection].permit(:name, :description, :image, :link)
  end
end
