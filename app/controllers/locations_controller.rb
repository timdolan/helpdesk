class LocationsController < ApplicationController

  before_filter :admin_user
  
  def index
    @location = Location.all
    @title = "Location"
  end

  def show
    @location = Location.find(params[:id])
    @title = @location.name
  end
  
  def new
    @title = "Add Location"
    @location = Location.new
  end
  
  def create
    @location = Location.new(params[:location])
    if @location.save
      flash[:success] = "New location saved!"
      redirect_to locations_path
    else
      @title = "Add Location"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit Location"
    @location = Location.find(params[:id])
  end
  
  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      
      flash[:success] = "Location updated"
      redirect_to locations_path
    else
      @title = "Edit Location"
      render 'edit'
    end
  end
  
  def destroy
    Location.find(params[:id]).destroy
    flash[:success] = "Location deleted."
    redirect_to locations_path 
  end
end