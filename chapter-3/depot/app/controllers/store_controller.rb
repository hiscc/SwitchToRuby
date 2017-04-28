class StoreController < ApplicationController
  def index
    @ps = P.order(:title)
  end
end
