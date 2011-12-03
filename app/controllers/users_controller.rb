class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  def index
    @user = User.all
    @title = "Users"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.last_name
  end
  
  def new
    @title = "Sign Up"
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Help Desk"
      redirect_to root_path
    else
      @title = "Sign Up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit User"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      @title = "Edit User"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_path
  end

end