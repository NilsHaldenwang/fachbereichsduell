class PresentationController < ApplicationController
  def index
    render :index, layout: false
  end
end
