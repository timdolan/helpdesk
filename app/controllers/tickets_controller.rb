class TicketsController < ApplicationController

  before_filter :authenticate, :only => [:show, :new, :create]
  before_filter :worker_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  def index
    @ticket = Ticket.all
    @title = "Tickets"
  end

  def show
    @ticket = Ticket.find(params[:id])
    @title = @ticket.title
    @comment = Comment.new
  end
  
  def new
    @title = "Create Ticket"
    @ticket = Ticket.new
  end
  
  def create
    @ticket = Ticket.new(params[:ticket])
    @user = User.find(current_user.id)
    @location = Location.find(@user.location_id)
    
    @ticket.contact = current_user.id unless !@ticket.contact.nil?
    @ticket.ticket_type = "request for service" if @ticket.ticket_type.nil? or @ticket.ticket_type == ""
    @ticket.priority = "medium" if @ticket.priority.nil? or @ticket.priority == ""
    @ticket.urgency = "medium" if @ticket.urgency.nil? or @ticket.urgency == ""
    @ticket.impact = "medium" if @ticket.impact.nil? or @ticket.impact == ""
    @ticket.status = "open" if @ticket.status.nil? or @ticket.status == ""
    @ticket.assigned_to = @location.user_id if @ticket.assigned_to.nil? or @ticket.assigned_to == ""
    
    if @ticket.save
      flash[:success] = "New ticket created"
      redirect_to root_path
    else
      @title = "Create Ticket"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit Ticket"
    @ticket = Ticket.find(params[:id])
  end
  
  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      flash[:success] = "Ticket updated"
      redirect_to @ticket
    else
      @title = "Edit Ticket"
      render 'edit'
    end
  end
  
  def destroy
    Ticket.find(params[:id]).destroy
    flash[:success] = "Ticket deleted."
    redirect_to root_path 
  end
end