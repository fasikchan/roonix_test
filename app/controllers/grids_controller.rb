class GridsController < ApplicationController
  def index
    service = CreateGridService.new
    service.call
    
    @grid = service.grid
  end
end