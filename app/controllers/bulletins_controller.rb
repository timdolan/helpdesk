class BulletinsController < ApplicationController

  before_filter :admin_user, :except => [:index, :show]

  def index
    @bulletin = Bulletin.all
    @title = "Bulletins"
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    @title = @bulletin.title
  end
  
  def new
    @title = "Add Bulletin"
    @bulletin = Bulletin.new
  end
  
  def create
    @bulletin = Bulletin.new(params[:bulletin])
    if @bulletin.save
      flash[:success] = "New bulletin added"
      redirect_to @bulletin
    else
      @title = "Add bulletin"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit Bulletin"
    @bulletin = Bulletin.find(params[:id])
  end
  
  def update
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.update_attributes(params[:bulletin])
      flash[:success] = "Bulletin updated"
      redirect_to @bulletin
    else
      @title = "Edit Bulletin"
      render 'edit'
    end
  end
  
  def destroy
    Bulletin.find(params[:id]).destroy
    flash[:success] = "Bulletin deleted."
    redirect_to bulletins_path 
  end

end
