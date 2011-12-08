class TicketsController < ApplicationController

  def index
    @ticket = Ticket.all
    @title = "Tickets"
  end

  def show
    @ticket = Ticket.find(params[:id])
    @title = @ticket.title
  end
  
  def new
    @title = "Create Ticket"
    @ticket = Ticket.new
  end
  
  def create
    @ticket = Ticket.new(params[:ticket])
    @ticket.contact = current_user unless !@ticket.contact.nil?
    @ticket.ticket_type = "request for service" unless !@ticket.ticket_type.nil?
    @ticket.priority = "medium" unless !@ticket.priority.nil?
    @ticket.urgency = "medium" unless !@ticket.urgency.nil?
    @ticket.impact = "medium" unless !@ticket.impact.nil?
    @ticket.status = "open" unless !@ticket.status.nil?
    @ticket.assigned_to = "1" unless !@ticket.assigned_to.nil?
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

  def userTickets
    @ticket = Ticket.where("contact = ?", current_user)
  end
end
